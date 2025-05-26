#!/bin/bash

BACKUP_DIR="/etc/backup/backups"
DB_NAME="Projecte"
DB_USER="root"
DB_PASS="Educem00."
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_$DATE.sql"

if [ ! -d "$BACKUP_DIR" ]; then
    echo "La carpeta $BACKUP_DIR no existe. Creándola..."
    mkdir -p "$BACKUP_DIR"
    if [ $? -ne 0 ]; then
        echo "Error al crear la carpeta $BACKUP_DIR. Saliendo."
        exit 1
    fi
fi

echo "Realizando el dump de la base de datos $DB_NAME..."
mariadb-dump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_FILE"

if [ $? -eq 0 ]; then
    echo "Backup completado: $BACKUP_FILE"
else
    echo "Error al realizar el backup."
    exit 1
fi