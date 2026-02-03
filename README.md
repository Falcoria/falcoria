# Falcoria

Quick-start Docker Compose setup for running a single-node Falcoria instance.

## Services

- **ScanLedger** — core ledger service
- **Tasker** — task scheduler and dispatcher
- **Worker** — task executor (single instance; workers can be distributed separately)
- **PostgreSQL** — primary database
- **Redis** — caching and state
- **RabbitMQ** — message broker between Tasker and Workers

## Requirements

- Docker 20.10+
- Docker Compose 2.0+

## Ports

- **443** — ScanLedger API
- **8443** — Tasker API

## Quick Start

Run the quickstart script to generate TLS certificates, secure credentials, and start all services:

```bash
chmod +x quickstart.sh
./quickstart.sh
```

The script will output your admin token — store it securely.

## Manual Setup

1. Generate a TLS bundle and place it in `certs/bundle.pem`.
2. Copy the example env file and fill in your secrets:

```bash
cp .env.example .env
```

3. Start all services:

```bash
docker compose up -d
```

## Console Client

After installation, you can use [falcli](https://github.com/Falcoria/falcli) — the console native client to work with Falcoria.

## Scaling Workers

This setup includes a single worker. For distributed deployments, run additional worker instances on separate hosts pointing to the same RabbitMQ and Redis.

## Repositories

- [ScanLedger](https://github.com/Falcoria/scanledger)
- [Tasker](https://github.com/Falcoria/tasker)
- [Worker](https://github.com/Falcoria/worker)
- [falcli](https://github.com/Falcoria/falcli)
