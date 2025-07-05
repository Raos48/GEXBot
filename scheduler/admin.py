from django.contrib import admin
from .models import Contact, Group, MessageTemplate, ScheduledMessage, MessageLog, EvolutionConfig

@admin.register(Contact)
class ContactAdmin(admin.ModelAdmin):
    list_display = ('name', 'phone_number', 'is_active', 'created_at')
    list_filter = ('is_active',)
    search_fields = ('name', 'phone_number')
    readonly_fields = ('id', 'created_at', 'updated_at')

@admin.register(Group)
class GroupAdmin(admin.ModelAdmin):
    # CORREÇÃO: Adicionado 'group_id' para ser visível e pesquisável
    list_display = ('name', 'group_id', 'is_active', 'created_at')
    list_filter = ('is_active',)
    search_fields = ('name', 'group_id')
    readonly_fields = ('id', 'created_at', 'updated_at')

@admin.register(MessageTemplate)
class MessageTemplateAdmin(admin.ModelAdmin):
    list_display = ('title', 'media_type', 'is_active')
    list_filter = ('media_type', 'is_active')
    search_fields = ('title', 'content')
    readonly_fields = ('id', 'created_at', 'updated_at')

@admin.register(ScheduledMessage)
class ScheduledMessageAdmin(admin.ModelAdmin):
    list_display = ('title', 'recipient_display', 'frequency', 'next_execution', 'status')
    list_filter = ('status', 'frequency', 'recipient_type')
    search_fields = ('title',)
    readonly_fields = ('id', 'last_sent', 'created_at', 'updated_at')
    actions = ['activate_schedules', 'pause_schedules']
    fieldsets = (
        ('Informações Gerais', {
            'fields': ('title', 'message_template')
        }),
        ('Destinatário', {
            'description': "Escolha o tipo de destinatário e preencha o campo correspondente.",
            'fields': ('recipient_type', 'contact', 'group')
        }),
        ('Configuração de Agendamento', {
            'fields': ('frequency', 'start_date', 'end_date', 'day_of_week', 'day_of_month')
        }),
        ('Status e Controle', {
            'fields': ('status', 'next_execution', 'last_sent')
        }),
    )

    def recipient_display(self, obj):
        if obj.recipient_type == 'contact' and obj.contact:
            return f"Contato: {obj.contact.name}"
        if obj.recipient_type == 'group' and obj.group:
            return f"Grupo: {obj.group.name}"
        return "N/D"
    recipient_display.short_description = "Destinatário"

    @admin.action(description='Ativar agendamentos selecionados')
    def activate_schedules(self, request, queryset):
        queryset.update(status='active')
        self.message_user(request, f"{queryset.count()} agendamentos foram ativados com sucesso.")

    @admin.action(description='Pausar agendamentos selecionados')
    def pause_schedules(self, request, queryset):
        queryset.update(status='paused')
        self.message_user(request, f"{queryset.count()} agendamentos foram pausados com sucesso.")

@admin.register(MessageLog)
class MessageLogAdmin(admin.ModelAdmin):
    list_display = ('scheduled_message', 'recipient', 'status', 'sent_at', 'evolution_message_id')
    list_filter = ('status',)
    search_fields = ('recipient', 'evolution_message_id', 'scheduled_message__title')
    readonly_fields = [field.name for field in MessageLog._meta.fields]

    def has_add_permission(self, request):
        return False

    def has_change_permission(self, request, obj=None):
        return False

    def has_delete_permission(self, request, obj=None):
        return False

@admin.register(EvolutionConfig)
class EvolutionConfigAdmin(admin.ModelAdmin):
    list_display = ('instance_name', 'base_url', 'is_active', 'is_connected', 'last_check')
    list_filter = ('is_active', 'is_connected')
    search_fields = ('instance_name', 'base_url')
    readonly_fields = ('id', 'created_at', 'updated_at', 'last_check', 'is_connected')
