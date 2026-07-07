# Deploy and Host

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.com/new/template/beszel)

![Beszel OG Image](https://raw.githubusercontent.com/INAPP-Mobile/railway-beszel/main/og-image.svg)

Beszel is a lightweight server monitoring platform with historical data, Docker stats, and alert functions. Deploy it on Railway in minutes to start monitoring your servers — no external database required.

## About Hosting

Beszel runs as a single Docker container (hub) on port 8090. Railway provides compute, TLS at the edge, and a public URL. The hub stores all monitoring data at `/beszel_data` — add a Railway Volume there to persist metrics across restarts. Agents run on your monitored servers and stream data to the hub via WebSocket.

## Why Deploy

- **Ultra-lightweight** — ~32MB image, ~12MB RAM at idle. Smaller and less resource-intensive than leading solutions.
- **Zero external database** — Built on PocketBase, everything runs in one container with embedded storage.
- **Docker stats** — Tracks CPU, memory, and network usage history for each container.
- **Alerts** — Configurable alerts via Discord, Slack, Gotify, email, and webhook for CPU, memory, disk, bandwidth, temperature, and more.
- **GPU monitoring** — Nvidia, AMD, and Intel GPU metrics with power draw tracking.
- **Multi-user** — Users manage their own systems. Admins can share systems across users.
- **OAuth / OIDC** — Supports many OAuth2 providers. Password auth can be disabled.
- **Automatic backups** — Save to and restore from disk or S3-compatible storage.

## Common Use Cases

- **Infrastructure monitoring** — Keep tabs on all your servers, VPS instances, and containers from one dashboard.
- **Container resource tracking** — Monitor CPU, memory, and network per-container across your Docker/Podman hosts.
- **Alert-driven operations** — Get notified when disk fills up, CPU spikes, or a service goes down.
- **Multi-server fleet management** — Deploy agents across staging, production, and development environments.
- **GPU workload monitoring** — Track GPU utilization, temperature, and power draw for AI/ML workloads.

## Dependencies for Beszel

### Deployment Dependencies

Beszel is a standalone service that requires no external dependencies on Railway. It uses embedded PocketBase storage and runs entirely within its single container. Add a Railway Volume at `/beszel_data` for persistent metric history.

---

# Beszel — Lightweight Server Monitoring

> A lightweight server monitoring platform with historical data, Docker stats, and alert functions. Smaller and less resource-intensive than leading solutions.

## Features

- **Lightweight** — Smaller and less resource-intensive than leading solutions
- **Simple** — Easy setup with little manual configuration required
- **Docker stats** — Tracks CPU, memory, and network usage history for each container
- **Alerts** — Configurable alerts for CPU, memory, disk, bandwidth, temperature, and more
- **Multi-user** — Users manage their own systems. Admins can share systems across users
- **OAuth / OIDC** — Supports many OAuth2 providers. Password auth can be disabled
- **Automatic backups** — Save to and restore from disk or S3-compatible storage
- **GPU monitoring** — Nvidia, AMD, and Intel GPU metrics
- **S.M.A.R.T.** — Disk health monitoring including eMMC wear and Linux mdraid arrays

## Architecture

```
┌─────────────────┐      ┌─────────────────┐
│   Beszel Hub   │◄─────│  Beszel Agent   │
│  (on Railway)  │ ws   │  (on your VPS)  │
│  Port 8090     │      │  Port 45876     │
│  /beszel_data  │      │                 │
└─────────────────┘      └─────────────────┘
```

The **Hub** (this template) runs on Railway and provides the web dashboard. **Agents** run on each server you want to monitor and stream metrics to the hub via WebSocket.

## Environment Variables

| Variable | Default | Required | Description |
|----------|---------|----------|-------------|
| `PORT` | `8090` | ✅ | Internal listen port (must match Railway's routing) |
| `APP_URL` | — | ❌ | Public URL for links in emails/notifications |
| `AUTO_LOGIN` | — | ❌ | Email to auto-authenticate (skip login page) |
| `DISABLE_PASSWORD_AUTH` | — | ❌ | Disable password auth, use OAuth/OIDC only |
| `CHECK_UPDATES` | `false` | ❌ | Check for updates on the hub |
| `CONTAINER_DETAILS` | `true` | ❌ | Allow viewing container inspect/logs in UI |
| `DISCORD_WEBHOOK_URL` | — | ❌ | Default Discord alert webhook |
| `SLACK_WEBHOOK_URL` | — | ❌ | Default Slack alert webhook |
| `GOTIFY_URL` | — | ❌ | Default Gotify alert URL |
| `GOTIFY_TOKEN` | — | ❌ | Default Gotify alert token |
| `S3_ENDPOINT` | — | ❌ | S3-compatible backup endpoint |
| `S3_REGION` | — | ❌ | S3 backup region |
| `S3_BUCKET` | — | ❌ | S3 backup bucket |
| `S3_ACCESS_KEY_ID` | — | ❌ | S3 backup access key |
| `S3_SECRET_ACCESS_KEY` | — | ❌ | S3 backup secret key |

## Volumes

| Mount | Description |
|-------|-------------|
| `/beszel_data` | Persistent storage for metrics, config, and database |

Add a Railway Volume at `/beszel_data` to persist your monitoring data across restarts.

## How to Use

1. Click the **Deploy on Railway** button above
2. Add a Railway Volume at `/beszel_data` for persistence
3. Once deployed, navigate to your Railway URL and create an admin account
4. Add systems to monitor — copy the agent install command from the dashboard
5. Run the agent command on each server you want to monitor

## Adding Agents

After creating an admin account, click the **+** button in the top-right corner to add a new system. Choose a connection method:
- **Remote agent** — Run a Docker or binary agent on a remote server
- **Local Unix Socket** — Monitor the Railway host itself

## Screenshots

| Dashboard | System Page | Settings |
|-----------|-------------|----------|
| *Coming soon* | *Coming soon* | *Coming soon* |

## Local Development

```bash
git clone https://github.com/INAPP-Mobile/railway-beszel.git
cd railway-beszel
docker compose up -d
# Or with Podman:
podman compose up -d
```

## Troubleshooting

**Q: The dashboard shows "Service Unavailable"**
A: Make sure `PORT=8090` is set in your Railway environment. The Beszel hub listens on port 8090 and Railway needs to route traffic there.

**Q: Agents aren't connecting**
A: Verify the hub URL and key in the agent configuration. Ensure your firewall allows WebSocket connections.

**Q: How do I reset the admin password?**
A: Delete the `/beszel_data` volume and restart — you'll be prompted to create a new admin account.

## License

This template packages [Beszel](https://github.com/henrygd/beszel) which is licensed under the **MIT License**. See the [LICENSE](https://github.com/henrygd/beszel/blob/main/LICENSE) for details.
