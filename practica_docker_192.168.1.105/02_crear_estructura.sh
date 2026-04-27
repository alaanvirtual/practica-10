#!/bin/bash
# ─── Crear estructura de directorios del proyecto ─────────────────────────────
set -e

PROJECT_DIR="$HOME/practica_docker"

echo "Creando estructura en $PROJECT_DIR ..."

mkdir -p $PROJECT_DIR/{nginx/html/css,nginx/html/img,nginx/conf,postgres/init,ftp/data,backups}

cat << 'TREE' > $PROJECT_DIR/estructura.txt
practica_docker/
├── docker-compose.yml
├── nginx/
│   ├── Dockerfile
│   ├── conf/
│   │   └── nginx.conf
│   └── html/
│       ├── index.html
│       ├── css/
│       │   └── style.css
│       └── img/
│           └── logo.svg
├── postgres/
│   └── init/
│       └── init.sql
├── ftp/
│   └── data/     <- volumen compartido ftp + nginx
└── backups/      <- respaldos automaticos de postgresql
TREE

echo ""
cat $PROJECT_DIR/estructura.txt
echo ""
echo "Estructura creada en: $PROJECT_DIR"
