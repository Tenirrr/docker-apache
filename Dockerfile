FROM alpine:latest

# Instalacja Apache2 i wymaganych pakietów
RUN apk update && apk add --no-cache \
    apache2 \
    apache2-ssl \
    apache2-proxy \
    curl \
    nano \
    bash \
    && rm -rf /var/cache/apk/*

# Tworzenie podstawowych katalogów
RUN mkdir -p /var/www/html \
    && mkdir -p /var/log/apache2

# Porty
EXPOSE 80
EXPOSE 443

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Uruchomienie Apache
CMD ["httpd", "-D", "FOREGROUND"]