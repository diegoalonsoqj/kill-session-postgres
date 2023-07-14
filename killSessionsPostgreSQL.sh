#!/bin/bash

# Variables de conexión a la base de datos PostgreSQL
HOST="localhost"
USER="usuario"
PASSWORD="contraseña"
DATABASE="nombre_basedatos"

# Ruta del archivo de registro
LOG_FILE="/ruta/archivo.log"

# Obtener la lista de sesiones en estado IDLE, excluyendo las sesiones del usuario postgres
SESSIONS=$(psql -h "$HOST" -U "$USER" -d "$DATABASE" -t -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.state = 'idle' AND pg_stat_activity.usename != 'postgres';")

# Obtener la fecha actual
FECHA=$(date +%Y-%m-%d)

# Registrar los eventos en el archivo de registro
echo "[$FECHA] - Se han terminado las siguientes sesiones en estado IDLE:" >> "$LOG_FILE"
echo "$SESSIONS" >> "$LOG_FILE"