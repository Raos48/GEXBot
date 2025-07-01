# whatsapp_scheduler/celery.py

import os
from celery import Celery

# Define o módulo de configurações do Django para o Celery
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'whatsapp_scheduler.settings')

# Cria a instância da aplicação Celery
app = Celery('whatsapp_scheduler')

# Carrega as configurações do Celery a partir do settings.py do Django
# O namespace='CELERY' significa que todas as configs devem começar com CELERY_
# Ex: CELERY_BROKER_URL, CELERY_RESULT_BACKEND
app.config_from_object('django.conf:settings', namespace='CELERY')

# ESTA É A LINHA MAIS IMPORTANTE:
# O Celery irá procurar automaticamente por arquivos tasks.py em todos os apps
# listados no INSTALLED_APPS do seu projeto Django.
app.autodiscover_tasks()

@app.task(bind=True)
def debug_task(self):
    print(f'Request: {self.request!r}')