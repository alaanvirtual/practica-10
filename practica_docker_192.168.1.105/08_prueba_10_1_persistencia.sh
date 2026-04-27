#!/bin/bash
# ─── Prueba 10.1: Persistencia de BD ─────────────────────────────────────────
echo "=== PRUEBA 10.1: PERSISTENCIA DE BASE DE DATOS ==="
echo ""

echo "[1] Insertando dato de prueba..."
docker exec postgres_db psql -U admin -d usuarios_db -c \
  "INSERT INTO usuarios (nombre, correo) VALUES ('Prueba Persistencia', 'prueba@test.com');"

echo ""
echo "[2] Datos ANTES de eliminar el contenedor:"
docker exec postgres_db psql -U admin -d usuarios_db -c "SELECT * FROM usuarios;"

echo ""
echo "[3] Eliminando contenedor postgres_db..."
docker rm -f postgres_db

echo ""
echo "[4] Levantando nuevo contenedor (usara el volumen db_data)..."
cd $HOME/practica_docker && docker compose up -d postgres
sleep 5

echo ""
echo "[5] Datos DESPUES de recrear el contenedor:"
docker exec postgres_db psql -U admin -d usuarios_db -c "SELECT * FROM usuarios;"

echo ""
echo "Si los datos persisten -> PRUEBA EXITOSA"
