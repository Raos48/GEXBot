# scheduler/services/evolution_service.py
import requests
import logging
from django.conf import settings
from typing import Dict, Any, Optional
import os

logger = logging.getLogger(__name__)

class EvolutionAPIService:
    def __init__(self):
        self.base_url = settings.EVOLUTION_API_BASE_URL
        self.api_key = settings.EVOLUTION_API_KEY
        self.instance_name = settings.EVOLUTION_INSTANCE_NAME
        self.headers = {
            'Content-Type': 'application/json',
            'apikey': self.api_key
        }

    def _make_request(self, method: str, endpoint: str, data: Dict = None, files: Dict = None) -> Dict[str, Any]:
        """Faz requisição para a API Evolution"""
        url = f"{self.base_url}/{endpoint}"
        
        try:
            if files:
                # Remove Content-Type header para upload de arquivos
                headers = {'apikey': self.api_key}
                response = requests.request(method, url, headers=headers, data=data, files=files)
            else:
                response = requests.request(method, url, headers=self.headers, json=data)
            
            response.raise_for_status()
            return {
                'success': True,
                'data': response.json() if response.content else {},
                'status_code': response.status_code
            }
        except requests.exceptions.RequestException as e:
            logger.error(f"Evolution API Error: {str(e)}")
            return {
                'success': False,
                'error': str(e),
                'status_code': getattr(e.response, 'status_code', 500) if hasattr(e, 'response') else 500
            }

    def check_instance_status(self) -> Dict[str, Any]:
        """Verifica status da instância"""
        endpoint = f"instance/connectionState/{self.instance_name}"
        return self._make_request('GET', endpoint)

    def send_text_message(self, number: str, message: str) -> Dict[str, Any]:
        """Envia mensagem de texto"""
        endpoint = f"message/sendText/{self.instance_name}"
        data = {
            "number": number,
            "text": message
        }
        return self._make_request('POST', endpoint, data)

    def send_media_message(self, number: str, caption: str, media_path: str, media_type: str) -> Dict[str, Any]:
        """Envia mensagem com mídia"""
        endpoint = f"message/sendMedia/{self.instance_name}"
        
        # Determina o tipo de mídia baseado no media_type
        media_field = {
            'image': 'image',
            'document': 'document',
            'audio': 'audio'
        }.get(media_type, 'document')
        
        try:
            with open(media_path, 'rb') as file:
                files = {
                    media_field: file
                }
                data = {
                    'number': number,
                    'caption': caption if media_type != 'audio' else ''
                }
                return self._make_request('POST', endpoint, data, files)
        except FileNotFoundError:
            return {
                'success': False,
                'error': f'Arquivo não encontrado: {media_path}',
                'status_code': 404
            }

    def send_group_text_message(self, group_id: str, message: str) -> Dict[str, Any]:
        """Envia mensagem de texto para grupo"""
        endpoint = f"message/sendText/{self.instance_name}"
        data = {
            "number": group_id,
            "text": message
        }
        return self._make_request('POST', endpoint, data)

    def send_group_media_message(self, group_id: str, caption: str, media_path: str, media_type: str) -> Dict[str, Any]:
        """Envia mensagem com mídia para grupo"""
        endpoint = f"message/sendMedia/{self.instance_name}"
        
        media_field = {
            'image': 'image',
            'document': 'document',
            'audio': 'audio'
        }.get(media_type, 'document')
        
        try:
            with open(media_path, 'rb') as file:
                files = {
                    media_field: file
                }
                data = {
                    'number': group_id,
                    'caption': caption if media_type != 'audio' else ''
                }
                return self._make_request('POST', endpoint, data, files)
        except FileNotFoundError:
            return {
                'success': False,
                'error': f'Arquivo não encontrado: {media_path}',
                'status_code': 404
            }

    def get_profile_info(self, number: str) -> Dict[str, Any]:
        """Obtém informações do perfil"""
        endpoint = f"chat/whatsappProfile/{self.instance_name}"
        data = {"number": number}
        return self._make_request('POST', endpoint, data)

    def fetch_groups(self) -> Dict[str, Any]:
        """Lista todos os grupos"""
        endpoint = f"group/fetchAllGroups/{self.instance_name}"
        return self._make_request('GET', endpoint)

# Instância global do serviço
evolution_service = EvolutionAPIService()
