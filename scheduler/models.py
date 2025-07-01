from django.db import models
from django.utils import timezone
import uuid

class Contact(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=100, verbose_name="Nome")
    phone_number = models.CharField(max_length=20, unique=True, verbose_name="Número do Telefone")
    is_active = models.BooleanField(default=True, verbose_name="Ativo")
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="Criado em")
    updated_at = models.DateTimeField(auto_now=True, verbose_name="Atualizado em")

    def __str__(self):
        return f"{self.name} - {self.phone_number}"

    class Meta:
        verbose_name = "Contato"
        verbose_name_plural = "Contatos"
        ordering = ['name']

class Group(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=100, verbose_name="Nome do Grupo")
    group_id = models.CharField(max_length=100, unique=True, verbose_name="ID do Grupo no WhatsApp")
    description = models.TextField(blank=True, null=True, verbose_name="Descrição")
    is_active = models.BooleanField(default=True, verbose_name="Ativo")
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="Criado em")
    updated_at = models.DateTimeField(auto_now=True, verbose_name="Atualizado em")

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "Grupo"
        verbose_name_plural = "Grupos"
        ordering = ['name']

class MessageTemplate(models.Model):
    MEDIA_TYPES = [
        ('text', 'Texto'),
        ('image', 'Imagem'),
        ('document', 'Documento'),
        ('audio', 'Áudio'),
    ]

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    title = models.CharField(max_length=100, verbose_name="Título")
    content = models.TextField(verbose_name="Conteúdo da Mensagem")
    media_type = models.CharField(max_length=10, choices=MEDIA_TYPES, default='text', verbose_name="Tipo de Mídia")
    media_file = models.FileField(upload_to='message_media/', blank=True, null=True, verbose_name="Arquivo de Mídia")
    is_active = models.BooleanField(default=True, verbose_name="Ativo")
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="Criado em")
    updated_at = models.DateTimeField(auto_now=True, verbose_name="Atualizado em")

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = "Template de Mensagem"
        verbose_name_plural = "Templates de Mensagens"
        ordering = ['title']

class ScheduledMessage(models.Model):
    FREQUENCY_CHOICES = [
        ('once', 'Execução Única'),
        ('daily', 'Diário'),
        ('weekly', 'Semanal'),
        ('monthly', 'Mensal'),
        ('yearly', 'Anual'),
    ]

    STATUS_CHOICES = [
        ('active', 'Ativo'),
        ('paused', 'Pausado'),
        ('completed', 'Concluído'),
        ('failed', 'Falhou'),
    ]

    RECIPIENT_TYPES = [
        ('contact', 'Contato'),
        ('group', 'Grupo'),
    ]

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    title = models.CharField(max_length=100, verbose_name="Título do Agendamento")
    message_template = models.ForeignKey(MessageTemplate, on_delete=models.CASCADE, verbose_name="Template da Mensagem")
    
    # Destinatário
    recipient_type = models.CharField(max_length=10, choices=RECIPIENT_TYPES, verbose_name="Tipo de Destinatário")
    contact = models.ForeignKey(Contact, on_delete=models.CASCADE, blank=True, null=True, verbose_name="Contato")
    group = models.ForeignKey(Group, on_delete=models.CASCADE, blank=True, null=True, verbose_name="Grupo")
    
    # Agendamento
    frequency = models.CharField(max_length=10, choices=FREQUENCY_CHOICES, verbose_name="Frequência")
    start_date = models.DateTimeField(verbose_name="Data/Hora de Início")
    end_date = models.DateTimeField(blank=True, null=True, verbose_name="Data/Hora de Fim")
    
    # Para agendamentos semanais (0=Segunda, 6=Domingo)
    day_of_week = models.IntegerField(blank=True, null=True, verbose_name="Dia da Semana")
    
    # Para agendamentos mensais (1-31)
    day_of_month = models.IntegerField(blank=True, null=True, verbose_name="Dia do Mês")
    
    # Status
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='active', verbose_name="Status")
    last_sent = models.DateTimeField(blank=True, null=True, verbose_name="Último Envio")
    next_execution = models.DateTimeField(blank=True, null=True, verbose_name="Próxima Execução")
    
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="Criado em")
    updated_at = models.DateTimeField(auto_now=True, verbose_name="Atualizado em")

    def __str__(self):
        return f"{self.title} - {self.get_frequency_display()}"

    class Meta:
        verbose_name = "Mensagem Agendada"
        verbose_name_plural = "Mensagens Agendadas"
        ordering = ['-created_at']

class MessageLog(models.Model):
    STATUS_CHOICES = [
        ('pending', 'Pendente'),
        ('sent', 'Enviado'),
        ('failed', 'Falhou'),
        ('delivered', 'Entregue'),
        ('read', 'Lido'),
    ]

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    scheduled_message = models.ForeignKey(ScheduledMessage, on_delete=models.CASCADE, verbose_name="Mensagem Agendada")
    recipient = models.CharField(max_length=100, verbose_name="Destinatário")  # Phone number or group ID
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='pending', verbose_name="Status")
    sent_at = models.DateTimeField(auto_now_add=True, verbose_name="Enviado em")
    delivered_at = models.DateTimeField(blank=True, null=True, verbose_name="Entregue em")
    error_message = models.TextField(blank=True, null=True, verbose_name="Mensagem de Erro")
    evolution_message_id = models.CharField(max_length=100, blank=True, null=True, verbose_name="ID da Mensagem Evolution")

    def __str__(self):
        return f"{self.scheduled_message.title} - {self.recipient} - {self.status}"

    class Meta:
        verbose_name = "Log de Mensagem"
        verbose_name_plural = "Logs de Mensagens"
        ordering = ['-sent_at']

class EvolutionConfig(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    instance_name = models.CharField(max_length=100, unique=True, verbose_name="Nome da Instância")
    api_key = models.CharField(max_length=255, verbose_name="Chave da API")
    base_url = models.URLField(verbose_name="URL Base da API")
    webhook_url = models.URLField(blank=True, null=True, verbose_name="URL do Webhook")
    is_active = models.BooleanField(default=True, verbose_name="Ativo")
    is_connected = models.BooleanField(default=False, verbose_name="Conectado")
    last_check = models.DateTimeField(blank=True, null=True, verbose_name="Última Verificação")
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="Criado em")
    updated_at = models.DateTimeField(auto_now=True, verbose_name="Atualizado em")

    def __str__(self):
        return f"{self.instance_name} - {'Conectado' if self.is_connected else 'Desconectado'}"

    class Meta:
        verbose_name = "Configuração Evolution"
        verbose_name_plural = "Configurações Evolution"
        ordering = ['instance_name']
