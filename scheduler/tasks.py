# scheduler/tasks.py (VERSÃO REVISADA E CORRIGIDA)

from celery import shared_task
import requests
from django.conf import settings
import logging
from .utils.scheduler_utils import format_phone_number

logger = logging.getLogger(__name__)

@shared_task
def send_whatsapp_message(phone_number, message, instance_name=None):
    """
    Task do Celery para enviar mensagem WhatsApp via Evolution API
    """
    try:
        if not instance_name:
            instance_name = settings.EVOLUTION_INSTANCE_NAME
        
        api_url = settings.EVOLUTION_API_BASE_URL
        api_key = settings.EVOLUTION_API_KEY
        
        url = f"{api_url}/message/sendText/{instance_name}"
        
        headers = {
            'Content-Type': 'application/json',
            'apikey': api_key
        }
        
        formatted_number = format_phone_number(phone_number)
        
        # CORRIGIDO: Payload simplificado conforme a mensagem de erro da API
        payload = {
            "number": formatted_number,
            "text": message 
        }
        
        response = requests.post(url, json=payload, headers=headers, timeout=30)
        
        if response.status_code in [200, 201]:
            logger.info(f"Mensagem enviada com sucesso para {formatted_number}")
            return {"status": "success", "response": response.json()}
        else:
            logger.error(f"Erro ao enviar mensagem para {formatted_number}: {response.status_code} - {response.text}")
            return {"status": "error", "message": f"Erro HTTP {response.status_code}"}
            
    except Exception as e:
        logger.error(f"Erro fatal na task send_whatsapp_message: {str(e)}")
        return {"status": "error", "message": str(e)}

@shared_task
def test_task():
    """Task de teste"""
    logger.info("Executando task de teste!")
    return "Task de teste funcionando!"