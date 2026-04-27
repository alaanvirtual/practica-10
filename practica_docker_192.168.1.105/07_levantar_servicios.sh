#!/bin/bash
# ─── Levantar todos los servicios ─────────────────────────────────────────────
PROJECT_DIR="$HOME/practica_docker"
cd $PROJECT_DIR

echo "Construyendo imagenes y levantando contenedores..."
docker compose up -d --build

echo ""
echo "Estado de los contenedores:"
docker compose ps

echo ""
echo "Red infra_red:"
docker network inspect infra_red | grep -A5 '"Containers"'
