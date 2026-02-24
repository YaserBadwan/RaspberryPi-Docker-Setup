# RaspberryPi Docker Setup

A minimal, production-ready script to install Docker Engine on any **Raspberry Pi** running **Raspberry Pi OS**.

---

## What it does

1. Installs prerequisites (`ca-certificates`, `curl`, `gnupg`)
2. Adds Docker's official GPG key
3. Adds Docker's APT repository (auto-detects OS codename and CPU architecture)
4. Installs Docker Engine, CLI, containerd, Buildx, and Compose plugin
5. Enables and starts the Docker service
6. Adds the current user to the `docker` group

---

## Requirements

- Raspberry Pi
- Raspberry Pi OS
- Internet connection
- A user with `sudo` privileges

> The script auto-detects both the CPU architecture (`armv7l` / `arm64`) and the OS codename, so no manual configuration is needed.

---

## Usage

### 1. Clone the repo

```bash
git clone https://github.com/YaserBadwan/RaspberryPi-Docker-Setup.git
cd RaspberryPi-Docker-Setup
```

### 2. Run the script

```bash
./install-docker.sh
```

### 3. Apply group changes

Log out and back in, or run:

```bash
newgrp docker
```

### 4. Verify

```bash
docker run --rm hello-world
docker compose version
```

---

## What gets installed

| Package | Purpose |
|---|---|
| `docker-ce` | Docker Engine |
| `docker-ce-cli` | Docker CLI |
| `containerd.io` | Container runtime |
| `docker-buildx-plugin` | Multi-platform image builds |
| `docker-compose-plugin` | Docker Compose v2 |

---

## Notes

- The script uses `set -euo pipefail` — it stops immediately on any error.
- Docker is enabled to start automatically on boot via `systemctl enable`.
- For containers to auto-restart after reboot, use `--restart unless-stopped` or `--restart always` when running them.

---

## License

MIT
