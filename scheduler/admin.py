# scheduler/admin.py

from django.contrib import admin
from .models import Contact, Group, MessageTemplate, ScheduledMessage, MessageLog, EvolutionConfig

# Decorator @admin.register é a forma moderna e limpa de registrar modelos
@admin.register(Contact)
class ContactAdmin(admin.ModelAdmin):
    # Campos a serem exibidos na lista de contatos
    list_display = ('name', 'phone_number', 'is_active', 'created_at')
    # Filtros que aparecerão na barra lateral direita
    list_filter = ('is_active',)
    # Campos nos quais a barra de pesquisa irá funcionar
    search_fields = ('name', 'phone_number')
    # Campos que serão apenas de leitura no formulário de edição
    readonly_fields = ('id', 'created_at', 'updated_at')

@admin.register(Group)
class GroupAdmin(admin.ModelAdmin):
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
    
    # Ações personalizadas que aparecerão no dropdown "Ações"
    actions = ['activate_schedules', 'pause_schedules']

    # Organiza os campos em grupos para um formulário mais limpo
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
        """Cria uma coluna mais informativa para o destinatário."""
        if obj.recipient_type == 'contact' and obj.contact:
            return f"Contato: {obj.contact.name}"
        if obj.recipient_type == 'group' and obj.group:
            return f"Grupo: {obj.group.name}"
        return "N/D"
    recipient_display.short_description = "Destinatário"

    @admin.action(description='Ativar agendamentos selecionados')
    def activate_schedules(self, request, queryset):
        """Ação para ativar agendamentos em massa."""
        queryset.update(status='active')
        self.message_user(request, f"{queryset.count()} agendamentos foram ativados com sucesso.")

    @admin.action(description='Pausar agendamentos selecionados')
    def pause_schedules(self, request, queryset):
        """Ação para pausar agendamentos em massa."""
        queryset.update(status='paused')
        self.message_user(request, f"{queryset.count()} agendamentos foram pausados com sucesso.")

@admin.register(MessageLog)
class MessageLogAdmin(admin.ModelAdmin):
    list_display = ('scheduled_message', 'recipient', 'status', 'sent_at', 'evolution_message_id')
    list_filter = ('status',)
    search_fields = ('recipient', 'evolution_message_id', 'scheduled_message__title')
    readonly_fields = [field.name for field in MessageLog._meta.fields] # Torna todos os campos somente leitura
    
    # Desabilita a permissão de adicionar, alterar ou deletar logs pelo admin
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

    # Exemplo de como você poderia adicionar uma ação para verificar a conexão
    # actions = ['check_connection_status']
    
    # @admin.action(description='Verificar conexão das instâncias selecionadas')
    # def check_connection_status(self, request, queryset):
    #     for config in queryset:
    #         # Aqui você chamaria a lógica para verificar a conexão da instância
    #         # Ex: result = config.verify_connection()
    #         pass 
    #     self.message_user(request, "Verificação de conexão iniciada.")