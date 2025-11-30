# syntax=docker/dockerfile:1

# Builder stage: install envsubst only
FROM alpine:3.21 AS builder
RUN apk add --no-cache gettext

# Final stage: lean Postgres image
FROM postgres:13-alpine

# Metadata args
ARG TZ=UTC
ARG POSTGRES_DB=sampledb
ARG POSTGRES_USER=postgres
# Do not default password to avoid embedding secrets

# Runtime env vars
ENV TZ=${TZ} \
    POSTGRES_DB=${POSTGRES_DB} \
    POSTGRES_USER=${POSTGRES_USER} 

# Install tzdata, copy envsubst from builder, then cleanup tzdata
RUN apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && apk del tzdata

# Copy envsubst binary and locale files from builder
COPY --from=builder /usr/bin/envsubst /usr/bin/envsubst
COPY --from=builder /usr/lib/libintl.so* /usr/lib/

# Copy init scripts
COPY initdb/create-db-sample.sql.template /docker-entrypoint-initdb.d/create-db-sample.sql.template
COPY initdb/init-db.sh                 /docker-entrypoint-initdb.d/init-db.sh
RUN chmod +x /docker-entrypoint-initdb.d/init-db.sh
# Copy low-memory postgres config
COPY postgresql.lowmem.conf /etc/postgresql/postgresql.conf

EXPOSE 5432
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]
