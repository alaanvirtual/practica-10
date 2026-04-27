#!/bin/bash
# ─── Configurar SSH desde Linux Mint ─────────────────────────────────────────
# EJECUTAR EN LINUX MINT CINNAMON 21.3

SERVER_IP="192.168.1.105"
SERVER_USER="nodo1"

echo "=== Configuracion SSH desde Linux Mint ==="
echo "Servidor: $SERVER_USER@$SERVER_IP"
echo ""

echo "[1] Instalando cliente SSH y herramientas..."
sudo apt install -y openssh-client curl ftp

echo ""
echo "[2] Generando par de claves SSH..."
if [ ! -f ~/.ssh/id_rsa ]; then
  ssh-keygen -t rsa -b 4096 -C "mint-cliente" -f ~/.ssh/id_rsa -N ""
  echo "Claves generadas en ~/.ssh/"
else
  echo "Ya existe un par de claves SSH."
fi

echo ""
echo "[3] Copiando clave publica al servidor (se pedira contrasena una sola vez)..."
ssh-copy-id ${SERVER_USER}@${SERVER_IP}

echo ""
echo "[4] Probando conexion SSH sin contrasena..."
ssh -o BatchMode=yes ${SERVER_USER}@${SERVER_IP} "echo 'Conexion SSH exitosa desde Mint'"

echo ""
echo "Agregando alias a ~/.bashrc..."
echo "alias ssh-server='ssh ${SERVER_USER}@${SERVER_IP}'" >> ~/.bashrc
source ~/.bashrc

echo ""
echo "Listo. Usa 'ssh-server' para conectarte rapidamente."
