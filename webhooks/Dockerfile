FROM theohbrothers/docker-webhook:2.8.1
RUN apk add --no-cache jq
COPY hooks.json /config/hooks.json
COPY deploy.sh /usr/local/bin/deploy.sh
RUN chmod +x /usr/local/bin/deploy.sh
