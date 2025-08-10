#!/bin/bash
set -e

# Start Docker daemon in background
dockerd --host=unix:///var/run/docker.sock > /var/log/dockerd.log 2>&1 &

echo "Waiting for Docker daemon to start..."
until docker info >/dev/null 2>&1; do
  sleep 0.5
done
echo "Docker daemon is ready."

# Execute whatever command was passed to container
exec "$@"
