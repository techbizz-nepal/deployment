#!/usr/bin/env sh
set -e

# Optional: redirect all output and errors to a log file
LOGFILE="/var/log/webhook/deploy.log"
mkdir -p "$(dirname "$LOGFILE")"
exec >> "$LOGFILE" 2>&1

log(){
  # use direct command substitution without escaping
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

log "Starting deploy script"

# read full JSON payload from stdin
payload=$(cat)

log "Payload received: $payload"

# extract GitHub repo full name
repo_full=$(printf '%s' "$payload" | jq -r '.repository.full_name')

log "Detected repo: $repo_full"

# map GitHub repo → services + images
case "$repo_full" in
  techbizz-nepal/bazzarify-consumer)
    services="consumer"
    images="techbizz/consumer:latest"
    ;;
  techbizz-nepal/bazzarify-vendor)
    services="vendor"
    images="techbizz/vendor:latest"
    ;;
  techbizz-nepal/ecommerce)
    services="frankenphp"
    images="techbizz/frankenphp:latest"
    ;;
  techbizz-nepal/deployment)
    services="nginx postgres"
    images="techbizz/nginx:latest techbizz/postgres:latest"
    ;;
  *)
    log "⚠️  Unrecognized repo: $repo_full; aborting."
    exit 1
    ;;
esac

log "Pulling images: $images"
for img in $images; do
  log "Pulling $img"
  docker pull "$img"
done

log "Restarting services: $services"
for svc in $services; do
  log "docker-compose -f /srv/deploy/docker-compose.yml up -d $svc"
  docker-compose -f /srv/deploy/docker-compose.yml up -d "$svc"
done

log "Deploy script completed"