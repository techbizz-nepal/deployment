#!/usr/bin/env sh
set -e

# read full JSON payload from stdin
payload="$(cat)"

# extract GitHub repo full name
repo_full=$(printf '%s' "$payload" | jq -r '.repository.full_name')

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
    echo "⚠️  Unrecognized repo: $repo_full; aborting." >&2
    exit 1
    ;;
esac

echo "→ Repo: $repo_full"
echo "→ Pulling images: $images"
echo "→ Restarting services: $services"

# pull and restart
for img in $images; do
  docker pull "$img"
done

for svc in $services; do
  docker-compose up -d "$svc"
done