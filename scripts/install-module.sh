#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <module-name>"
    echo "Przykłady: rewrite ssl headers proxy proxy_http"
    exit 1
fi

MODULE=$1
CONTAINER_NAME="apache-alpine"

# Sprawdź czy kontener jest uruchomiony
if ! docker ps | grep -q $CONTAINER_NAME; then
    echo "Kontener $CONTAINER_NAME nie jest uruchomiony!"
    exit 1
fi

# Włącz moduł w kontenerze
docker exec $CONTAINER_NAME sed -i "/LoadModule ${MODULE}_module/s/^#//g" /etc/apache2/httpd.conf

if [ $? -eq 0 ]; then
    echo "Moduł $MODULE został włączony."
    echo "Uruchom: ./manage-container.sh restart aby zastosować zmiany."
else
    echo "Błąd podczas włączania modułu $MODULE!"
    exit 1
fi
