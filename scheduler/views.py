# scheduler/views.py (VERSÃO COMPLETA E ATUALIZADA)

from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.views import APIView
from django.utils import timezone
from django.http import JsonResponse
from django.db.models import Count

from .models import (
    Contact, Group, MessageTemplate, ScheduledMessage, MessageLog, EvolutionConfig
)
from .serializers import (
    ContactSerializer, GroupSerializer, MessageTemplateSerializer,
    ScheduledMessageSerializer, MessageLogSerializer, EvolutionConfigSerializer
)

# --- ViewSets para o CRUD completo via API ---

class ContactViewSet(viewsets.ModelViewSet):
    """
    API endpoint para gerenciar Contatos.
    """
    queryset = Contact.objects.all().order_by('name')
    serializer_class = ContactSerializer

class GroupViewSet(viewsets.ModelViewSet):
    """
    API endpoint para gerenciar Grupos.
    """
    queryset = Group.objects.all().order_by('name')
    serializer_class = GroupSerializer

class MessageTemplateViewSet(viewsets.ModelViewSet):
    """
    API endpoint para gerenciar Templates de Mensagem.
    """
    queryset = MessageTemplate.objects.all().order_by('title')
    serializer_class = MessageTemplateSerializer

class ScheduledMessageViewSet(viewsets.ModelViewSet):
    """
    API endpoint para gerenciar Agendamentos de Mensagens.
    """
    queryset = ScheduledMessage.objects.all().order_by('-created_at')
    serializer_class = ScheduledMessageSerializer

    @action(detail=False, methods=['get'])
    def upcoming(self, request):
        """
        Retorna uma lista de agendamentos ativos que ainda serão executados.
        """
        upcoming_schedules = ScheduledMessage.objects.filter(
            status='active',
            next_execution__gte=timezone.now()
        ).order_by('next_execution')
        
        page = self.paginate_queryset(upcoming_schedules)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(upcoming_schedules, many=True)
        return Response(serializer.data)

    @action(detail=False, methods=['get'])
    def overdue(self, request):
        """
        Retorna uma lista de agendamentos ativos que estão atrasados.
        """
        overdue_schedules = ScheduledMessage.objects.filter(
            status='active',
            next_execution__lt=timezone.now()
        ).order_by('next_execution')

        page = self.paginate_queryset(overdue_schedules)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(overdue_schedules, many=True)
        return Response(serializer.data)

class MessageLogViewSet(viewsets.ReadOnlyModelViewSet):
    """
    Logs são apenas para leitura via API.
    """
    queryset = MessageLog.objects.all().order_by('-sent_at')
    serializer_class = MessageLogSerializer

class EvolutionConfigViewSet(viewsets.ModelViewSet):
    """
    API endpoint para gerenciar as configurações da Evolution API.
    """
    queryset = EvolutionConfig.objects.all().order_by('instance_name')
    serializer_class = EvolutionConfigSerializer

# --- Views Específicas para Dashboard e Outros ---

class DashboardStatsView(APIView):
    """
    Retorna estatísticas agregadas para o dashboard.
    """
    def get(self, request, format=None):
        schedule_stats = ScheduledMessage.objects.values('status').annotate(count=Count('status'))
        log_stats = MessageLog.objects.values('status').annotate(count=Count('status'))
        
        data = {
            'schedule_summary': {item['status']: item['count'] for item in schedule_stats},
            'log_summary': {item['status']: item['count'] for item in log_stats},
            'total_schedules': ScheduledMessage.objects.count(),
            'total_logs': MessageLog.objects.count()
        }
        return Response(data)

def health_check(request):
    """Health check simples para monitoramento."""
    return JsonResponse({
        'status': 'healthy',
        'timestamp': timezone.now().isoformat()
    })