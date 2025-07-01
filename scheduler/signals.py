# scheduler/signals.py (VERSÃO CORRIGIDA E COMPLETA)

import json
from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver
from django_celery_beat.models import PeriodicTask, IntervalSchedule, CrontabSchedule, ClockedSchedule
from .models import ScheduledMessage

@receiver(post_save, sender=ScheduledMessage)
def create_or_update_periodic_task(sender, instance, created, **kwargs):
    """
    Cria ou atualiza uma PeriodicTask correspondente quando um
    ScheduledMessage é salvo.
    """
    task_name = f'whatsapp-schedule-{instance.id}'

    # Se o agendamento está inativo ou completo, simplesmente desabilitamos a tarefa e saímos.
    if instance.status != 'active':
        try:
            ptask = PeriodicTask.objects.get(name=task_name)
            ptask.enabled = False
            ptask.save()
        except PeriodicTask.DoesNotExist:
            pass  # Se a tarefa não existe, não há nada a fazer.
        return

    # Lógica para determinar o tipo de agendamento (schedule)
    schedule = None
    schedule_type = None

    if instance.frequency == 'once':
        # Para execução única, usamos ClockedSchedule
        schedule, _ = ClockedSchedule.objects.get_or_create(clocked_time=instance.start_date)
        schedule_type = 'clocked'
    
    elif instance.frequency == 'daily':
        # Para execuções diárias, usamos CrontabSchedule
        schedule, _ = CrontabSchedule.objects.get_or_create(
            minute=instance.start_date.minute,
            hour=instance.start_date.hour,
            day_of_week='*',
            day_of_month='*',
            month_of_year='*',
        )
        schedule_type = 'crontab'

    elif instance.frequency == 'weekly':
        # Para execuções semanais
        schedule, _ = CrontabSchedule.objects.get_or_create(
            minute=instance.start_date.minute,
            hour=instance.start_date.hour,
            day_of_week=instance.day_of_week,
        )
        schedule_type = 'crontab'
        
    elif instance.frequency == 'monthly':
        # Para execuções mensais
        schedule, _ = CrontabSchedule.objects.get_or_create(
            minute=instance.start_date.minute,
            hour=instance.start_date.hour,
            day_of_month=instance.day_of_month,
        )
        schedule_type = 'crontab'

    # Se não houver um tipo de agendamento válido, não fazemos nada
    if not schedule_type:
        return

    # Prepara os argumentos para a task do Celery
    recipient_number = instance.contact.phone_number if instance.contact else instance.group.group_id
    task_args = json.dumps([recipient_number, instance.message_template.content])

    # Prepara os campos para a PeriodicTask
    task_data = {
        'task': 'scheduler.tasks.send_whatsapp_message',
        'name': task_name,
        'args': task_args,
        'enabled': True,
        'one_off': instance.frequency == 'once',
        # Zera os outros tipos de agendamento para evitar conflitos
        'interval': None,
        'crontab': None,
        'solar': None,
        'clocked': None,
    }
    
    # Atribui o schedule ao campo correto
    task_data[schedule_type] = schedule

    # Usa update_or_create para criar ou atualizar a tarefa de forma atômica
    PeriodicTask.objects.update_or_create(
        name=task_name,
        defaults=task_data
    )

@receiver(post_delete, sender=ScheduledMessage)
def delete_periodic_task(sender, instance, **kwargs):
    """
    Deleta a PeriodicTask correspondente quando um ScheduledMessage é deletado.
    """
    task_name = f'whatsapp-schedule-{instance.id}'
    try:
        ptask = PeriodicTask.objects.get(name=task_name)
        ptask.delete()
    except PeriodicTask.DoesNotExist:
        pass  # A tarefa não existe mais, nada a fazer.