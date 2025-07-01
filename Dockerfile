# Dockerfile
FROM python:3.11-slim

WORKDIR /app

# Instalar dependências do sistema, incluindo as necessárias para o mysqlclient
RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Copiar e instalar requirements primeiro (para cache)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar código da aplicação
COPY . .

# Criar diretórios necessários
RUN mkdir -p /app/logs /app/media /app/db

# Variáveis de ambiente
ENV PYTHONPATH=/app
ENV PYTHONUNBUFFERED=1

# Comando padrão (será sobrescrito pelo docker-compose, mas é uma boa prática ter)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]