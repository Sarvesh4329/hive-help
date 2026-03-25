#!/bin/bash
# Setup Docker and Docker Compose on Ubuntu

set -e

echo "Updating system..."
sudo apt-get update

echo "Installing Docker..."
sudo apt-get install -y docker.io docker-compose-v2

echo "Enabling Docker service..."
sudo systemctl enable --now docker

echo "Adding current user to docker group..."
sudo usermod -aG docker $USER

echo "Checking for k3s..."
if command -v k3s >/dev/null 2>&1; then
	echo "k3s already installed. Skipping."
else
	echo "Installing k3s..."
	curl -sfL https://get.k3s.io | sudo sh -
	sudo systemctl enable --now k3s
fi

echo "✅ Setup complete! Please log out and log back in for group changes to take effect."
echo "Or run: newgrp docker"
