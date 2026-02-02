#!/bin/bash

set -e

echo "Starting Falcoria quickstart..."

# Generate TLS certificates
echo "Generating TLS certificates..."
mkdir -p certs
if [ ! -f certs/bundle.pem ]; then
  openssl req -x509 -nodes -newkey rsa:2048 \
    -keyout certs/key.pem -out certs/cert.pem \
    -days 365 -subj "/CN=falcoria" 2>/dev/null
  cat certs/cert.pem certs/key.pem > certs/bundle.pem
  echo "TLS bundle generated."
else
  echo "TLS bundle already exists, skipping."
fi

# Setup environment file
echo "Setting up environment file..."
cp .env.example .env

# Generate random credentials (alphanumeric, 30 chars)
echo "Generating secure credentials..."
POSTGRES_PASSWORD=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 30)
ADMIN_TOKEN=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 30)
TASKER_TOKEN=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 30)
REDIS_PASSWORD=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 30)
RABBITMQ_PASSWORD=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 30)

# Update .env file with generated values
sed -i "s/POSTGRES_PASSWORD=changeme/POSTGRES_PASSWORD=$POSTGRES_PASSWORD/" .env
sed -i "s/SCANLEDGER_ADMIN_TOKEN=changeme/SCANLEDGER_ADMIN_TOKEN=$ADMIN_TOKEN/" .env
sed -i "s/SCANLEDGER_TASKER_TOKEN=changeme/SCANLEDGER_TASKER_TOKEN=$TASKER_TOKEN/" .env
sed -i "s/REDIS_PASSWORD=changeme/REDIS_PASSWORD=$REDIS_PASSWORD/" .env
sed -i "s/RABBITMQ_PASSWORD=changeme/RABBITMQ_PASSWORD=$RABBITMQ_PASSWORD/" .env

# Start Docker containers
echo "Starting Docker containers..."
docker compose up -d

# Wait for services to come up
echo "Waiting for services to start..."
sleep 10

# Health check
if curl -sk https://localhost/health >/dev/null 2>&1; then
  echo "ScanLedger is up and responding."
else
  echo "ScanLedger did not respond on https://localhost/health"
  echo "Check container logs if the problem persists."
fi

echo ""
echo "Quickstart complete."
echo ""
echo "========================================"
echo "Admin Token: $ADMIN_TOKEN"
echo "========================================"
echo ""
echo "ScanLedger:  https://localhost"
echo "Tasker:      https://localhost:8443"
echo ""
echo "Note: Store the admin token securely. You'll need it for API authentication."
