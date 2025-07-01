# scheduler/serializers.py (VERSÃO COMPLETA E CORRIGIDA)

from rest_framework import serializers
from .models import Contact, Group, MessageTemplate, ScheduledMessage, MessageLog, EvolutionConfig

class ContactSerializer(serializers.ModelSerializer):
    class Meta:
        model = Contact
        fields = '__all__' # Inclui todos os campos do modelo

class GroupSerializer(serializers.ModelSerializer):
    class Meta:
        model = Group
        fields = '__all__'

class MessageTemplateSerializer(serializers.ModelSerializer):
    class Meta:
        model = MessageTemplate
        fields = '__all__'

class ScheduledMessageSerializer(serializers.ModelSerializer):
    # Usar serializers aninhados para mostrar os detalhes, não apenas o ID.
    contact = ContactSerializer(read_only=True)
    group = GroupSerializer(read_only=True)
    message_template = MessageTemplateSerializer(read_only=True)

    # Campos para permitir a escrita usando apenas o ID
    contact_id = serializers.UUIDField(write_only=True, required=False, allow_null=True)
    group_id = serializers.UUIDField(write_only=True, required=False, allow_null=True)
    message_template_id = serializers.UUIDField(write_only=True)

    class Meta:
        model = ScheduledMessage
        fields = [
            'id', 'title', 'message_template', 'recipient_type', 'contact', 'group',
            'frequency', 'start_date', 'end_date', 'day_of_week', 'day_of_month',
            'status', 'last_sent', 'next_execution', 'created_at', 'updated_at',
            # Campos de escrita
            'contact_id', 'group_id', 'message_template_id'
        ]
        read_only_fields = ('id', 'created_at', 'updated_at', 'last_sent', 'next_execution')

    def create(self, validated_data):
        # Lógica para associar os IDs recebidos aos campos de ForeignKey
        validated_data['contact_id'] = validated_data.pop('contact_id', None)
        validated_data['group_id'] = validated_data.pop('group_id', None)
        validated_data['message_template_id'] = validated_data.pop('message_template_id')
        return super().create(validated_data)

class MessageLogSerializer(serializers.ModelSerializer):
    class Meta:
        model = MessageLog
        fields = '__all__'

class EvolutionConfigSerializer(serializers.ModelSerializer):
    class Meta:
        model = EvolutionConfig
        fields = '__all__'