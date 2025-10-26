#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <site-name>"
    exit 1
fi

SITE_NAME=$1
HOST_DIR="$HOME/apache2"
TARGET="$HOST_DIR/sites-enabled/${SITE_NAME}.conf"

if [ ! -f "$TARGET" ]; then
    echo "Strona ${SITE_NAME} nie jest włączona!"
    exit 1
fi

rm "$TARGET"
echo "Strona ${SITE_NAME} została wyłączona."
echo "Uruchom: ./manage-container.sh restart aby zastosować zmiany."
