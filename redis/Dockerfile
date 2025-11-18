FROM redis:latest
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN mkdir -p /var/log/redis
RUN chown redis:redis /var/log/redis && \
    chmod 755 /var/log/redis
CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]