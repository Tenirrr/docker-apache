#!/bin/bash

IMAGE_NAME="apache-alpine"
HOST_DIR="$HOME/apache2"

echo "Budowanie obrazu Apache Alpine..."
docker build -t $IMAGE_NAME $HOST_DIR

if [ $? -eq 0 ]; then
    echo "Obraz $IMAGE_NAME został pomyślnie zbudowany!"
    echo "Uruchom kontener: ./run-container.sh"
else
    echo "Błąd podczas budowania obrazu!"
    exit 1
fi