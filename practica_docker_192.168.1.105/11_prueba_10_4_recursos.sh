#!/bin/bash
# ─── Prueba 10.4: Limites de recursos ────────────────────────────────────────
echo "=== PRUEBA 10.4: LIMITES DE RECURSOS ==="
echo ""

echo "[1] Limites configurados en nginx_web:"
docker inspect nginx_web --format='
Memoria limite: {{.HostConfig.Memory}} bytes
NanoCPUs:       {{.HostConfig.NanoCpus}}
'

echo "[2] Limites configurados en postgres_db:"
docker inspect postgres_db --format='
Memoria limite: {{.HostConfig.Memory}} bytes
NanoCPUs:       {{.HostConfig.NanoCpus}}
'

echo ""
echo "[3] Docker stats (snapshot):"
docker stats --no-stream --format \
  "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}\t{{.NetIO}}"

echo ""
echo "Limites esperados:"
echo "  nginx_web   -> 512 MB RAM, 0.5 CPU"
echo "  postgres_db -> 512 MB RAM, 0.5 CPU"
echo "  ftp_server  -> 256 MB RAM, 0.25 CPU"
