#!/bin/bash
# 3. Скрипт для автоматичного резервного копіювання

BACKUP_DIR="./backups"
SOURCE_DIR="./jenkins_data/master_home"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

mkdir -p $BACKUP_DIR

echo "Starting backup of Jenkins home..."
tar -czf $BACKUP_DIR/jenkins_backup_$TIMESTAMP.tar.gz $SOURCE_DIR

echo "Backup completed: $BACKUP_DIR/jenkins_backup_$TIMESTAMP.tar.gz"

# Видалення старих бекапів (старше 7 днів)
find $BACKUP_DIR -name "jenkins_backup_*.tar.gz" -mtime +7 -delete
