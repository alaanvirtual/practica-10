#!/bin/bash
# ─── Instalar Docker en Ubuntu Server 24.04 ───────────────────────────────────
set -e

echo "[1/5] Actualizando paquetes..."
sudo apt update && sudo apt upgrade -y

echo "[2/5] Instalando dependencias..."
sudo apt install -y ca-certificates curl gnupg lsb-release

echo "[3/5] Agregando repositorio oficial de Docker..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "[4/5] Instalando Docker Engine + Compose..."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io \
  docker-buildx-plugin docker-compose-plugin

echo "[5/5] Configurando usuario actual en grupo docker..."
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker

echo ""
echo "Docker instalado correctamente."
echo "Version: $(docker --version)"
echo "IMPORTANTE: Cierra y vuelve a abrir la sesion SSH para aplicar el grupo docker."
