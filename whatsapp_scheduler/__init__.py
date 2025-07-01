# whatsapp_scheduler/__init__.py

# Isso garante que a aplicação Celery seja carregada quando o Django iniciar.
from .celery import app as celery_app

__all__ = ('celery_app',)