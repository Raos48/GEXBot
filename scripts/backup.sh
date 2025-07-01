#!/bin/bash

# Criar diretório se não existir
mkdir -p /backups/mysql
mkdir -p /backups/logs

# Configurações
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/backups"
MYSQL_BACKUP="$BACKUP_DIR/mysql/backup_$DATE.sql"
LOG_FILE="$BACKUP_DIR/logs/backup_$DATE.log"

echo "=== INICIANDO BACKUP - $DATE ===" > $LOG_FILE

# Backup do MySQL
echo "Fazendo backup do MySQL..." >> $LOG_FILE
if mysqldump -h $DB_HOST -u $DB_USER -p$DB_PASSWORD $DB_NAME > $MYSQL_BACKUP 2>>$LOG_FILE; then
    echo "✅ Backup MySQL concluído: $MYSQL_BACKUP" >> $LOG_FILE
    
    # Comprimir backup
    gzip $MYSQL_BACKUP
    echo "✅ Backup comprimido: $MYSQL_BACKUP.gz" >> $LOG_FILE
else
    echo "❌ Erro no backup MySQL" >> $LOG_FILE
    exit 1
fi

# Limpar backups antigos (manter últimos 7 dias)
echo "Limpando backups antigos..." >> $LOG_FILE
find $BACKUP_DIR/mysql -name "*.gz" -mtime +7 -delete
find $BACKUP_DIR/logs -name "*.log" -mtime +30 -delete

# Estatísticas
BACKUP_SIZE=$(du -sh $MYSQL_BACKUP.gz | cut -f1)
echo "📊 Tamanho do backup: $BACKUP_SIZE" >> $LOG_FILE
echo "=== BACKUP FINALIZADO - $DATE ===" >> $LOG_FILE

# Exibir no console também
cat $LOG_FILE
