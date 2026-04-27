#!/bin/bash
# ─── Crear docker-compose.yml ─────────────────────────────────────────────────
PROJECT_DIR="$HOME/practica_docker"

cat << 'COMPOSE' > $PROJECT_DIR/docker-compose.yml
version: '3.8'

networks:
  infra_red:
    name: infra_red
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/16

volumes:
  db_data:
    name: db_data
  web_content:
    name: web_content

services:

  nginx:
    build:
      context: ./nginx
      dockerfile: Dockerfile
    container_name: nginx_web
    restart: unless-stopped
    ports:
      - "80:80"
    volumes:
      - web_content:/var/www/html
      - ./nginx/html:/var/www/html
      - ./ftp/data:/var/www/ftp:ro
    networks:
      infra_red:
        ipv4_address: 172.20.0.10
    deploy:
      resources:
        limits:
          memory: 512m
          cpus: '0.50'
    depends_on:
      - postgres
      - ftp

  postgres:
    image: postgres:15-alpine
    container_name: postgres_db
    restart: unless-stopped
    environment:
      POSTGRES_USER: admin
      POSTGRES_PASSWORD: Admin1234
      POSTGRES_DB: usuarios_db
    volumes:
      - db_data:/var/lib/postgresql/data
      - ./postgres/init:/docker-entrypoint-initdb.d
      - ./backups:/backups
    networks:
      infra_red:
        ipv4_address: 172.20.0.20
    deploy:
      resources:
        limits:
          memory: 512m
          cpus: '0.50'

  ftp:
    image: fauria/vsftpd
    container_name: ftp_server
    restart: unless-stopped
    ports:
      - "20:20"
      - "21:21"
      - "21100-21110:21100-21110"
    environment:
      FTP_USER: ftpuser
      FTP_PASS: Ftp1234
      PASV_ADDRESS: 192.168.1.105
      PASV_MIN_PORT: 21100
      PASV_MAX_PORT: 21110
    volumes:
      - ./ftp/data:/home/vsftpd/ftpuser
    networks:
      infra_red:
        ipv4_address: 172.20.0.30
    deploy:
      resources:
        limits:
          memory: 256m
          cpus: '0.25'

  pg_backup:
    image: postgres:15-alpine
    container_name: pg_backup
    restart: "no"
    depends_on:
      - postgres
    environment:
      PGPASSWORD: Admin1234
    volumes:
      - ./backups:/backups
    networks:
      - infra_red
    entrypoint: >
      sh -c "sleep 10 &&
             pg_dump -h postgres_db -U admin usuarios_db
             > /backups/backup_$$(date +%Y%m%d_%H%M%S).sql &&
             echo 'Respaldo completado.'"
COMPOSE

echo "docker-compose.yml creado con PASV_ADDRESS=192.168.1.105"
echo ""
echo "Para levantar todos los servicios:"
echo "  cd $PROJECT_DIR && docker compose up -d --build"
