#!/bin/sh

docker_build() {
  docker-compose -f $DOCKER_COMPOSE_FILE_PATH build
}
docker_up() {
  docker-compose -f $DOCKER_COMPOSE_FILE_PATH up -d
}
docker_down() {
  docker-compose -f $DOCKER_COMPOSE_FILE_PATH down --remove-orphans
}