# scheduler/signals.py
import json
from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver
from django_celery_beat.models import PeriodicTask, CrontabSchedule, ClockedSchedule
from .models import ScheduledMessage

@receiver(post_save, sender=ScheduledMessage)
def create_or_update_periodic_task(sender, instance, created, **kwargs):
    """
    Cria ou atualiza uma PeriodicTask correspondente quando um
    ScheduledMessage é salvo.
    """
    task_name = f'whatsapp-schedule-{instance.id}'
    # Se o agendamento não estiver 'ativo', desabilitamos a tarefa e saímos.
    if instance.status != 'active':
        PeriodicTask.objects.filter(name=task_name).update(enabled=False)
        return

    schedule = None
    schedule_type = None

    if instance.frequency == 'once':
        schedule, _ = ClockedSchedule.objects.get_or_create(clocked_time=instance.start_date)
        schedule_type = 'clocked'

    elif instance.frequency == 'daily':
        schedule, _ = CrontabSchedule.objects.get_or_create(
            minute=instance.start_date.minute, hour=instance.start_date.hour,
            day_of_week='*', day_of_month='*', month_of_year='*'
        )
        schedule_type = 'crontab'

    elif instance.frequency == 'weekly' and instance.day_of_week is not None:
        schedule, _ = CrontabSchedule.objects.get_or_create(
            minute=instance.start_date.minute, hour=instance.start_date.hour,
            day_of_week=instance.day_of_week
        )
        schedule_type = 'crontab'

    elif instance.frequency == 'monthly' and instance.day_of_month is not None:
        schedule, _ = CrontabSchedule.objects.get_or_create(
            minute=instance.start_date.minute, hour=instance.start_date.hour,
            day_of_month=instance.day_of_month
        )
        schedule_type = 'crontab'

    # <<< ADICIONADO ESTE BLOCO PARA CORRIGIR A FALHA >>>
    elif instance.frequency == 'yearly':
        schedule, _ = CrontabSchedule.objects.get_or_create(
            minute=instance.start_date.minute,
            hour=instance.start_date.hour,
            day_of_month=instance.start_date.day,
            month_of_year=instance.start_date.month
        )
        schedule_type = 'crontab'
    # <<< FIM DO BLOCO ADICIONADO >>>

    if not schedule_type:
        # Se a frequência não for válida ou não tiver os dados necessários, desabilita e sai
        PeriodicTask.objects.filter(name=task_name).update(enabled=False)
        return

    task_data = {
        'task': 'scheduler.tasks.process_scheduled_message',
        'name': task_name,
        'kwargs': json.dumps({'schedule_id': str(instance.id)}),
        'args': '[]',
        'enabled': True,
        'one_off': instance.frequency == 'once',
    }

    # Limpa os campos de agendamento antes de definir o correto
    task_data.update({
        'interval': None, 'crontab': None, 'solar': None, 'clocked': None
    })
    task_data[schedule_type] = schedule
    PeriodicTask.objects.update_or_create(name=task_name, defaults=task_data)

@receiver(post_delete, sender=ScheduledMessage)
def delete_periodic_task(sender, instance, **kwargs):
    """
    Deleta a PeriodicTask correspondente quando um ScheduledMessage é deletado.
    """
    task_name = f'whatsapp-schedule-{instance.id}'
    PeriodicTask.objects.filter(name=task_name).delete()
