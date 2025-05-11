#!/usr/bin/env bash
set -e

# Generate actual SQL from template
envsubst < /docker-entrypoint-initdb.d/create-db-sample.sql.template \
    > /docker-entrypoint-initdb.d/create-db-sample.sql
