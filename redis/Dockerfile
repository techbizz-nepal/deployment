FROM redis:latest

COPY redis.conf /usr/local/etc/redis/redis.conf

RUN mkdir -p /var/lib/redis /var/log/redis && \
    chown -R redis:redis /var/lib/redis /var/log/redis && \
    chmod 755 /var/lib/redis /var/log/redis

USER redis

CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]
