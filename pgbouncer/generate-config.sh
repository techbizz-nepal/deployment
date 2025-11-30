#!/bin/sh
set -e

echo "\"${POSTGRES_USER}\" \"${POSTGRES_PASSWORD}\"" > /etc/pgbouncer/userlist.txt

exec /entrypoint.sh "$@"
