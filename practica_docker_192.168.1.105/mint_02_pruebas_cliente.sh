#!/bin/bash
# ─── Pruebas desde Linux Mint ─────────────────────────────────────────────────
# EJECUTAR EN LINUX MINT CINNAMON 21.3

SERVER_IP="192.168.1.105"

echo "=== Pruebas de conectividad desde Linux Mint ==="
echo "Servidor objetivo: $SERVER_IP"
echo ""

echo "[1] Ping al servidor:"
ping -c 4 $SERVER_IP

echo ""
echo "[2] Acceso HTTP al servidor Nginx:"
curl -I http://$SERVER_IP/
echo ""
curl -s http://$SERVER_IP/ | grep "<title>"

echo ""
echo "[3] Acceso a la carpeta de uploads FTP:"
curl -s http://$SERVER_IP/uploads/ | head -20

echo ""
echo "[4] Subida de archivo via FTP desde Mint:"
echo "Archivo desde Linux Mint - $(date)" > /tmp/desde_mint.txt
ftp -inv $SERVER_IP 21 << FTP
user ftpuser Ftp1234
put /tmp/desde_mint.txt desde_mint.txt
ls
bye
FTP

echo ""
echo "[5] Verificando archivo subido via HTTP:"
curl -s http://$SERVER_IP/uploads/desde_mint.txt

echo ""
echo "=== Pruebas completadas ==="
echo "Navega a: http://$SERVER_IP/"
echo "Archivos FTP: http://$SERVER_IP/uploads/"
