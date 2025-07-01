# Terminal 1 - Django Server
python manage.py runserver

# Terminal 2 - Celery Worker
celery -A whatsapp_scheduler worker --loglevel=info --pool=solo

# Terminal 3 - Celery Beat (agendador)
celery -A whatsapp_scheduler beat --loglevel=info

# Terminal 4 - Monitoramento (opcional)
python manage.py monitor_schedules --detailed



# Parar qualquer container rodando
docker-compose down

# Limpar sistema
docker system prune -f

# Construir e iniciar
docker-compose up --build

# Ou em background
docker-compose up --build -d

# Ver logs em tempo real
docker-compose logs -f