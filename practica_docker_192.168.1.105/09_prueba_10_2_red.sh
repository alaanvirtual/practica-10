#!/bin/bash
# ─── Prueba 10.2: Aislamiento de red ─────────────────────────────────────────
echo "=== PRUEBA 10.2: AISLAMIENTO DE RED ==="
echo ""

echo "[1] Inspeccionando la red infra_red:"
docker network inspect infra_red | grep -A3 '"Name"'

echo ""
echo "[2] Ping desde nginx_web hacia postgres_db (por nombre):"
docker exec nginx_web ping -c 4 postgres_db

echo ""
echo "[3] Ping desde nginx_web hacia ftp_server:"
docker exec nginx_web ping -c 4 ftp_server

echo ""
echo "[4] IPs asignadas en infra_red:"
docker network inspect infra_red --format='{{range .Containers}}{{.Name}}: {{.IPv4Address}}{{"\n"}}{{end}}'

echo ""
echo "Si el ping responde por nombre -> PRUEBA EXITOSA"
