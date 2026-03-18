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

echo "✅ Setup complete! Please log out and log back in for group changes to take effect."
echo "Or run: newgrp docker"
