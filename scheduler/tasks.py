import logging
from celery import shared_task
from django.utils import timezone
from django.db import transaction
from .models import ScheduledMessage, MessageLog
from .services.evolution_service import EvolutionAPIService

logger = logging.getLogger(__name__)

@shared_task(bind=True, max_retries=3, default_retry_delay=60)
def process_scheduled_message(self, schedule_id):
    try:
        with transaction.atomic():
            scheduled_message = ScheduledMessage.objects.select_for_update().get(id=schedule_id)
    except ScheduledMessage.DoesNotExist:
        logger.error(f"ScheduledMessage with ID {schedule_id} not found.")
        return

    if scheduled_message.status != 'active':
        logger.info(f"ScheduledMessage {schedule_id} is not active. Status: {scheduled_message.status}. Skipping execution.")
        return

    message_template = scheduled_message.message_template
    recipients_data = []

    if scheduled_message.recipient_type == 'contact' and scheduled_message.contact:
        recipients_data.append({
            'phone_number': scheduled_message.contact.phone_number,
            'name': scheduled_message.contact.name
        })
    elif scheduled_message.recipient_type == 'group' and scheduled_message.group:
        recipients_data.append({
            'phone_number': scheduled_message.group.group_id,
            'name': scheduled_message.group.name
        })
    else:
        logger.warning(f"ScheduledMessage {schedule_id} has invalid recipient configuration.")
        scheduled_message.status = 'failed'
        scheduled_message.save(update_fields=['status'])
        return

    if not recipients_data:
        logger.warning(f"ScheduledMessage {schedule_id} has no valid recipients. Skipping send.")
        scheduled_message.status = 'failed'
        scheduled_message.save(update_fields=['status'])
        return

    evolution_service = EvolutionAPIService()
    all_recipients_sent_successfully = True

    for recipient_info in recipients_data:
        recipient_phone = recipient_info['phone_number']
        recipient_name = recipient_info['name']

        log_entry = MessageLog.objects.create(
            scheduled_message=scheduled_message,
            recipient=recipient_phone,
            status='pending'
        )
        try:
            response_data = None
            if message_template.media_type == 'text':
                response_data = evolution_service.send_text_message(
                    recipient_phone,
                    message_template.content
                )
            elif message_template.media_type in ['image', 'video', 'document'] and message_template.media_file:
                media_url = scheduled_message.message_template.media_file.url
                response_data = evolution_service.send_media_message(
                    recipient_phone,
                    message_template.content,
                    media_url,
                    message_template.media_type
                )
            else:
                raise ValueError(f"Tipo de mídia '{message_template.media_type}' não suportado ou arquivo ausente para {scheduled_message.id}.")

            if response_data and response_data.get('success'):
                log_entry.status = 'sent'
                log_entry.evolution_message_id = response_data.get('data', {}).get('key', {}).get('id')
                logger.info(f"Message {log_entry.id} sent successfully for schedule {schedule_id} to {recipient_phone}.")
            else:
                log_entry.status = 'failed'
                error_msg = response_data.get('error', 'Unknown API error') if response_data else 'No response from API'
                log_entry.error_message = f"API Error: {error_msg}"
                logger.error(f"Failed to send message {log_entry.id} for schedule {schedule_id} to {recipient_phone}: {log_entry.error_message}")
                all_recipients_sent_successfully = False

        except Exception as e:
            log_entry.status = 'failed'
            log_entry.error_message = f"Exceção na task: {e}"
            logger.error(f"Exception sending message {log_entry.id} for schedule {schedule_id} to {recipient_phone}: {e}", exc_info=True)
            all_recipients_sent_successfully = False
        finally:
            log_entry.sent_at = timezone.now()
            log_entry.save()

    scheduled_message.last_sent = timezone.now()
    next_run = scheduled_message.calculate_next_execution()
    scheduled_message.next_execution = next_run

    if not next_run:
        if scheduled_message.frequency == 'once' and all_recipients_sent_successfully:
            scheduled_message.status = 'completed'
        elif scheduled_message.frequency != 'once' and scheduled_message.end_date and scheduled_message.last_sent >= scheduled_message.end_date:
            scheduled_message.status = 'completed'
        else:
            scheduled_message.status = 'failed'

    if not all_recipients_sent_successfully and scheduled_message.frequency == 'once':
        scheduled_message.status = 'failed'

    scheduled_message.save(update_fields=['status', 'last_sent', 'next_execution'])
    logger.info(f"ScheduledMessage {schedule_id} processed. Next execution: {scheduled_message.next_execution}")