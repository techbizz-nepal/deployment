#!/usr/bin/env sh
set -e

# Optional: redirect all output and errors to a log file
LOGFILE="/var/log/webhook/deploy.log"
mkdir -p "$(dirname "$LOGFILE")"
exec >> "$LOGFILE" 2>&1

echo "[\$(date '+%Y-%m-%d %H:%M:%S')] Starting deploy script"

# read full JSON payload from stdin
payload="$(cat)"

echo "[\$(date '+%Y-%m-%d %H:%M:%S')] Payload received: $payload"

# extract GitHub repo full name
repo_full=$(printf '%s' "$payload" | jq -r '.repository.full_name')

echo "[\$(date '+%Y-%m-%d %H:%M:%S')] Detected repo: $repo_full"

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
    echo "[\$(date '+%Y-%m-%d %H:%M:%S')] ⚠️  Unrecognized repo: $repo_full; aborting."
    exit 1
    ;;
esac

echo "[\$(date '+%Y-%m-%d %H:%M:%S')] Pulling images: $images"
for img in $images; do
  echo "[\$(date '+%Y-%m-%d %H:%M:%S')] Pulling $img"
  docker pull "$img"
done

echo "[\$(date '+%Y-%m-%d %H:%M:%S')] Restarting services: $services"
for svc in $services; do
  echo "[\$(date '+%Y-%m-%d %H:%M:%S')] docker-compose up -d $svc"
  docker-compose up -d "$svc"
done

echo "[\$(date '+%Y-%m-%d %H:%M:%S')] Deploy script completed"