#!/bin/bash

# OpenWork Production Deployment Script for daviddai.click
# Usage: ./deploy.sh [up|down|restart|logs|status]

set -e

cd /root/openwork

COMPOSE_CMD="docker compose -f packaging/docker/docker-compose.prod.yml"

case "${1:-up}" in
    up)
        echo "Starting OpenWork production stack..."
        $COMPOSE_CMD up -d --build
        echo ""
        echo "Services started. Access at:"
        echo "  Web UI: https://app.daviddai.click"
        echo "  API:    https://api.daviddai.click"
        echo ""
        echo "View logs: $0 logs"
        ;;
    down)
        echo "Stopping OpenWork stack..."
        $COMPOSE_CMD down
        ;;
    restart)
        echo "Restarting OpenWork stack..."
        $COMPOSE_CMD restart
        ;;
    logs)
        $COMPOSE_CMD logs -f
        ;;
    status)
        $COMPOSE_CMD ps
        ;;
    *)
        echo "Usage: $0 {up|down|restart|logs|status}"
        echo "  up      - Start the stack (default)"
        echo "  down    - Stop the stack"
        echo "  restart - Restart the stack"
        echo "  logs    - Follow logs"
        echo "  status  - Show service status"
        exit 1
        ;;
esac
