#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <site-name>"
    exit 1
fi

SITE_NAME=$1
HOST_DIR="$HOME/apache2"
SOURCE="$HOST_DIR/sites-available/${SITE_NAME}.conf"
TARGET="$HOST_DIR/sites-enabled/${SITE_NAME}.conf"

if [ ! -f "$SOURCE" ]; then
    echo "Plik konfiguracyjny $SOURCE nie istnieje!"
    exit 1
fi

if [ -f "$TARGET" ]; then
    echo "Strona ${SITE_NAME} jest już włączona!"
    exit 1
fi

ln -s "$SOURCE" "$TARGET"
echo "Strona ${SITE_NAME} została włączona."
echo "Uruchom: ./manage-container.sh restart aby zastosować zmiany."
