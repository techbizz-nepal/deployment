init_app(){
  install_packages
  run_migrations
  if ! env_file_exists >> /dev/null 2>&1; then
    cp_env
    generate_key
  fi
}

run_migrations(){
  docker-compose -f $DOCKER_COMPOSE_FILE_PATH exec app php artisan migrate
}

install_packages(){
  docker-compose -f $DOCKER_COMPOSE_FILE_PATH exec app composer install
}

env_file_exists(){
  docker-compose -f $DOCKER_COMPOSE_FILE_PATH exec app ls .env
}

cp_env(){
  docker-compose -f $DOCKER_COMPOSE_FILE_PATH exec app cp .env.example .env
}

generate_key(){
  docker-compose -f $DOCKER_COMPOSE_FILE_PATH exec app php artisan key:generate
}