#!/bin/bash
# ─── Crear Dockerfile de Nginx personalizado ──────────────────────────────────
PROJECT_DIR="$HOME/practica_docker"

cat << 'DOCKERFILE' > $PROJECT_DIR/nginx/Dockerfile
# Imagen base ligera: Alpine Linux
FROM nginx:alpine

# Copiar configuracion personalizada (server_tokens off incluido)
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Copiar contenido web
COPY html/ /var/www/html/

# Crear usuario no administrativo y ajustar permisos
RUN addgroup -S webgroup && adduser -S webuser -G webgroup \
    && chown -R webuser:webgroup /var/www/html \
    && chown -R webuser:webgroup /var/cache/nginx \
    && chown -R webuser:webgroup /var/log/nginx \
    && touch /var/run/nginx.pid \
    && chown webuser:webgroup /var/run/nginx.pid

# Ejecutar nginx como usuario no-root
USER webuser

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
DOCKERFILE

cat << 'NGINXCONF' > $PROJECT_DIR/nginx/conf/nginx.conf
worker_processes auto;
pid /var/run/nginx.pid;
error_log /var/log/nginx/error.log warn;

events {
    worker_connections 1024;
}

http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    # Ocultar version del servidor
    server_tokens off;

    log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent"';
    access_log /var/log/nginx/access.log main;

    sendfile on;
    keepalive_timeout 65;

    server {
        listen 80;
        server_name localhost;
        root /var/www/html;
        index index.html;

        location ~* \.(css|js|png|jpg|gif|ico|svg)$ {
            expires 30d;
            add_header Cache-Control "public, immutable";
        }

        location / {
            try_files $uri $uri/ =404;
        }

        # Carpeta FTP compartida (prueba 10.3)
        location /uploads/ {
            alias /var/www/ftp/;
            autoindex on;
        }
    }
}
NGINXCONF

echo "Dockerfile de Nginx y nginx.conf creados correctamente."
