FROM edoburu/pgbouncer:v1.24.1-p1

USER root

RUN apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Kathmandu /etc/localtime \
    && echo "Asia/Kathmandu" > /etc/timezone \
    && apk del tzdata

# Create pgbouncer Linux user
RUN adduser -D -H -s /bin/sh pgbouncer

# Allow pgbouncer user to write to config directory
RUN mkdir -p /etc/pgbouncer \
    && chown -R pgbouncer:pgbouncer /etc/pgbouncer

# Copy generator script
COPY generate-config.sh /usr/local/bin/generate-config.sh
RUN chmod +x /usr/local/bin/generate-config.sh

# Switch to pgbouncer user
USER pgbouncer

ENTRYPOINT ["/usr/local/bin/generate-config.sh"]
CMD ["pgbouncer", "/etc/pgbouncer/pgbouncer.ini"]
