#!/usr/bin/env bash
set -euo pipefail

# Ensure we're in the project root
cd "$(dirname "$0")"

echo "🚀 Starting deployment with Docker Compose..."

# Pull latest images
docker compose pull

# Start/Update services
docker compose up -d

echo "✅ Deployment complete. Watchtower is now monitoring for updates."
