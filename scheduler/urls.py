# scheduler/urls.py (VERSÃO COMPLETA E ATUALIZADA)

from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    ContactViewSet, GroupViewSet, MessageTemplateViewSet,
    ScheduledMessageViewSet, MessageLogViewSet, EvolutionConfigViewSet,
    DashboardStatsView, # Importa a nova view do dashboard
    health_check
)

# O Router cria automaticamente as URLs para todos os ViewSets
router = DefaultRouter()
router.register(r'contacts', ContactViewSet, basename='contact')
router.register(r'groups', GroupViewSet, basename='group')
router.register(r'templates', MessageTemplateViewSet, basename='template')
router.register(r'schedules', ScheduledMessageViewSet, basename='schedule')
router.register(r'logs', MessageLogViewSet, basename='log')
router.register(r'evolution-configs', EvolutionConfigViewSet, basename='evolution-config')

urlpatterns = [
    # Inclui todas as URLs geradas pelo router
    path('', include(router.urls)),
    
    # Endpoint de Health Check
    path('health-check/', health_check, name='health-check'),

    # NOVO: Endpoint para estatísticas do Dashboard
    path('dashboard/stats/', DashboardStatsView.as_view(), name='dashboard-stats'),
]
