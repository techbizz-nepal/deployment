FROM nginx:alpine
ARG TZ=UTC+05:45
ENV TZ ${TZ}

COPY nginx.conf /etc/nginx/
COPY sites /etc/nginx/sites-available
COPY ssl /etc/nginx/ssl

RUN set -x ; \
    addgroup -g 82 -S www-data ; \
    adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

EXPOSE 80 443