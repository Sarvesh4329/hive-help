#!/usr/bin/env bash
set -euo pipefail

IMAGE="${IMAGE:-ghcr.io/sarvesh4329/hive-help-backend:latest}"
CONTAINER_NAME="${CONTAINER_NAME:-hive-help-backend}"
PORT="${PORT:-5000}"
ENV_FILE="${ENV_FILE:-.env}"

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
