#!/bin/sh

docker_build() {
  docker-compose -f $DOCKER_COMPOSE_FILE_PATH build
}
docker_up() {
  docker-compose -f $DOCKER_COMPOSE_FILE_PATH up -d
}
docker_down() {
  docker-compose -f $DOCKER_COMPOSE_FILE_PATH down
}

build_app() {
  docker-compose -f $DOCKER_COMPOSE_FILE_PATH exec app composer install
#  docker-compose -f $DOCKER_COMPOSE_FILE_PATH exec app chown -R $(id -u):www-data storage
#  docker-compose -f $DOCKER_COMPOSE_FILE_PATH exec app chown -R $(id -u):www-data bootstrap
#  docker-compose -f $DOCKER_COMPOSE_FILE_PATH exec app php artisan storage:link
}