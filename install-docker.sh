#!/usr/bin/env bash
set -euo pipefail

# 1) Pre-req: sudo session (ask once)
sudo -v

echo "[0/6] Removing old Docker versions if present..."
sudo apt remove -y docker docker.io docker-compose docker-doc podman-docker containerd runc 2>/dev/null || true

echo "[1/6] Installing prerequisites..."
sudo apt update
sudo apt install -y ca-certificates curl gnupg

echo "[2/6] Setting up Docker APT keyring..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod 0644 /etc/apt/keyrings/docker.gpg

echo "[3/6] Adding Docker APT repository..."
CODENAME="$(. /etc/os-release && echo "$VERSION_CODENAME")"
ARCH="$(dpkg --print-architecture)"
echo "deb [arch=${ARCH} signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian ${CODENAME} stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "[4/6] Installing Docker Engine + Compose..."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "[5/6] Enabling Docker service..."
sudo systemctl enable --now docker

echo "[6/6] Adding user '${USER}' to docker group..."
sudo usermod -aG docker "$USER"

echo ""
echo "Done."
echo "IMPORTANT: Log out/in (or run: newgrp docker) so group changes apply."
echo "Test after relog: docker run --rm hello-world && docker compose version"
