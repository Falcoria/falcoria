# Falcoria

Quick-start Docker Compose setup for running a single-node Falcoria instance.

## Services

- **ScanLedger** — core ledger service
- **Tasker** — task scheduler and dispatcher
- **Worker** — task executor (single instance; workers can be distributed separately)
- **PostgreSQL** — primary database
- **Redis** — caching and state
- **RabbitMQ** — message broker between Tasker and Workers

## Getting Started

1. Copy the example env file and fill in your secrets:

```bash
cp .env.example .env
```

2. Start all services:

```bash
docker compose up -d
```

## Scaling Workers

This setup includes a single worker. For distributed deployments, run additional worker instances on separate hosts pointing to the same RabbitMQ and Redis.

## Repositories

- [ScanLedger](https://github.com/Falcoria/scanledger)
- [Tasker](https://github.com/Falcoria/tasker)
- [Worker](https://github.com/Falcoria/worker)
