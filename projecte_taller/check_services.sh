#!/bin/bash
API_HOST="localhost"
API_PORT=5000
DB_USER="root"
DB_PASS="Educem00."
PORT_DB="3336"

echo "[$(date)] Script check_api.sh iniciado" >> /var/log/cron.log

# Comprobar API
RESPONSE=$(curl -s http://${API_HOST}:${API_PORT}/ping)
if [[ "$RESPONSE" == '{"message":"pong"}' ]]; then
    echo "API OK"
else
    echo "API KO"
fi

# Comprobar base de datos
if mariadb-admin ping -u"$DB_USER" -p"$DB_PASS" -P "$PORT_DB" --silent | grep -q "mysqld is alive"; then
    echo "DB OK"
else
    echo "DB KO"
fi

# Comprobar ping a la máquina 172.18.0.2
if ping -c 1 -W 2 $API_HOST:8080 > /dev/null 2>&1; then
    echo "WEB OK"
else
    echo "WEB KO"
fi

echo "[$(date)] Script check_api.sh terminado" >> /var/log/cron.log
