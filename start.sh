#!/bin/sh
set -e

# Start nginx in background
nginx

# Start backend
cd /app/backend
exec node app.js