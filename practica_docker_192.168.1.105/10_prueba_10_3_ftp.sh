#!/bin/bash
# ─── Prueba 10.3: Permisos FTP ────────────────────────────────────────────────
echo "=== PRUEBA 10.3: SUBIDA FTP Y ACCESO NGINX ==="
echo ""

SERVER_IP=$(hostname -I | awk '{print $1}')

echo "[1] Instalando cliente FTP si no existe..."
sudo apt install -y ftp 2>/dev/null || true

echo ""
echo "[2] Creando archivo de prueba..."
echo "Archivo subido via FTP - $(date)" > /tmp/archivo_prueba_ftp.txt

echo ""
echo "[3] Subiendo archivo al servidor FTP..."
ftp -inv $SERVER_IP 21 << FTP_CMDS
user ftpuser Ftp1234
put /tmp/archivo_prueba_ftp.txt archivo_prueba_ftp.txt
bye
FTP_CMDS

echo ""
echo "[4] Verificando archivo en el volumen compartido:"
ls -la $HOME/practica_docker/ftp/data/

echo ""
echo "[5] Accediendo al archivo via HTTP:"
curl -s http://localhost/uploads/archivo_prueba_ftp.txt

echo ""
echo "URL desde navegador: http://$SERVER_IP/uploads/"
echo "Si el archivo es accesible por HTTP -> PRUEBA EXITOSA"
