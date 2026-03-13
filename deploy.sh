#!/usr/bin/env bash
set -euo pipefail

IMAGE="${IMAGE:-ghcr.io/sarvesh4329/hive-help-backend:latest}"
CONTAINER_NAME="${CONTAINER_NAME:-hive-help-backend}"
PORT="${PORT:-5000}"
ENV_FILE="${ENV_FILE:-.env}"

if [ ! -f "$ENV_FILE" ]; then
  echo "Environment file '$ENV_FILE' not found. Create it from .env.example." >&2
  exit 1
fi

if ! grep -q '^MONGODB_URI=' "$ENV_FILE"; then
  echo "MONGODB_URI is required in $ENV_FILE to connect to MongoDB." >&2
  exit 1
fi

if ! grep -q '^JWT_SECRET=' "$ENV_FILE"; then
  echo "JWT_SECRET is required in $ENV_FILE for secure auth tokens." >&2
  exit 1
fi

docker pull "$IMAGE"

if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  docker stop "$CONTAINER_NAME"
  docker rm "$CONTAINER_NAME"
fi

docker run -d \
  --name "$CONTAINER_NAME" \
  --env-file "$ENV_FILE" \
  -p "${PORT}:5000" \
  --restart unless-stopped \
  "$IMAGE"
