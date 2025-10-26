#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <site-name>"
    exit 1
fi

SITE_NAME=$1
HOST_DIR="$HOME/apache2"
CONF_FILE="$HOST_DIR/sites-available/${SITE_NAME}.conf"

cat > "$CONF_FILE" << CONFEOF
<VirtualHost *:80>
    ServerName ${SITE_NAME}
    DocumentRoot /var/www/html/${SITE_NAME}
    
    <Directory /var/www/html/${SITE_NAME}>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    
    ErrorLog /var/log/apache2/${SITE_NAME}-error.log
    CustomLog /var/log/apache2/${SITE_NAME}-access.log combined
</VirtualHost>

<VirtualHost *:443>
    ServerName ${SITE_NAME}
    DocumentRoot /var/www/html/${SITE_NAME}
    
    SSLEngine on
    SSLCertificateFile /etc/letsencrypt/live/cives.pl/fullchain.pem
    SSLCertificateKeyFile /etc/letsencrypt/live/cives.pl/privkey.pem
    
    <Directory /var/www/html/${SITE_NAME}>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    
    ErrorLog /var/log/apache2/${SITE_NAME}-ssl-error.log
    CustomLog /var/log/apache2/${SITE_NAME}-ssl-access.log combined
</VirtualHost>
CONFEOF

mkdir -p "$HOST_DIR/www/${SITE_NAME}"
cat > "$HOST_DIR/www/${SITE_NAME}/index.html" << HTMLEOF
<!DOCTYPE html>
<html>
<head>
    <title>${SITE_NAME}</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        h1 { color: #333; }
    </style>
</head>
<body>
    <h1>Witaj na stronie ${SITE_NAME}</h1>
    <p>Strona działa poprawnie z SSL!</p>
    <p>Data utworzenia: $(date)</p>
</body>
</html>
HTMLEOF

echo "Strona ${SITE_NAME} została utworzona."
echo "Użyj './scripts/enable-site.sh ${SITE_NAME}' aby ją włączyć."
