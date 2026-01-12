FROM redis:latest

COPY redis.conf /usr/local/etc/redis/redis.conf

RUN mkdir -p /var/lib/redis/appendonly && \
    chown -R redis:redis /var/lib/redis && \
    chmod -R 755 /var/lib/redis

USER redis

CMD ["sh", "-c", "redis-server /usr/local/etc/redis/redis.conf --requirepass \"$REDIS_PASSWORD\""]
