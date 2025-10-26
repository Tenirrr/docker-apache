#!/bin/bash

CONTAINER_NAME="apache-alpine"
HOST_DIR="$HOME/apache2"

# Sprawdź czy kontener już istnieje
if docker ps -a | grep -q $CONTAINER_NAME; then
    echo "Usuwanie istniejącego kontenera..."
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
fi

# Uruchom nowy kontener
echo "Uruchamianie kontenera Apache..."
docker run -d \
    --name $CONTAINER_NAME \
    --restart unless-stopped \
    -p 80:80 \
    -p 443:443 \
    -v $HOST_DIR/config:/etc/apache2 \
    -v $HOST_DIR/www:/var/www \
    -v $HOST_DIR/logi:/var/log/apache2 \
    -v /home/docker-user/certbot-ovh/letsencrypt/live/cives.pl:/etc/letsencrypt/live/cives.pl:ro \
    apache-alpine

echo "Kontener $CONTAINER_NAME uruchomiony!"
echo "Logi: docker logs -f $CONTAINER_NAME"
echo "Shell: docker exec -it $CONTAINER_NAME /bin/bash"
echo "Restart: docker restart $CONTAINER_NAME"