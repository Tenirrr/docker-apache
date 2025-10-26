#!/bin/bash

CONTAINER_NAME="apache-alpine"

case "$1" in
    start)
        docker start $CONTAINER_NAME
        echo "Kontener $CONTAINER_NAME uruchomiony"
        ;;
    stop)
        docker stop $CONTAINER_NAME
        echo "Kontener $CONTAINER_NAME zatrzymany"
        ;;
    restart)
        docker restart $CONTAINER_NAME
        echo "Kontener $CONTAINER_NAME zrestartowany"
        ;;
    logs)
        docker logs -f $CONTAINER_NAME
        ;;
    shell)
        docker exec -it $CONTAINER_NAME /bin/bash
        ;;
    status)
        docker ps | grep $CONTAINER_NAME
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|logs|shell|status}"
        exit 1
        ;;
esac