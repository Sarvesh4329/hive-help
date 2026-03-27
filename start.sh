#!/bin/sh
set -e

echo "Starting nginx..."
nginx -t  # Test configuration
nginx

echo "Nginx started successfully"

# Wait a moment for nginx to fully start
sleep 2

echo "Checking nginx status..."
if ! pgrep -x "nginx" > /dev/null; then
    echo "ERROR: Nginx failed to start"
    exit 1
fi

if [ ! -f "/usr/share/nginx/html/index.html" ]; then
    echo "ERROR: index.html not found in /usr/share/nginx/html/"
    ls -la /usr/share/nginx/html/
    exit 1
fi

echo "Creating debug test.html..."
echo "<html><body><h1>Nginx is working</h1></body></html>" > /usr/share/nginx/html/test.html
chmod 644 /usr/share/nginx/html/test.html
chmod 755 /usr/share/nginx/html/

echo "Frontend files found. Testing nginx response..."
curl -I http://localhost/ || echo "Warning: Local curl test failed, but Nginx might still be working"

echo "Checking Nginx process..."
ps aux | grep nginx

echo "Starting backend in background..."
cd /app/backend
node app.js &

# Wait for backend to start
sleep 5

echo "Starting nginx in foreground..."
nginx