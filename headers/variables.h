#!/bin/sh

FIRST_ARG="$1"
DOCKER_COMPOSE_FILE_PATH="$SCRIPT_DIR/docker-compose.yaml"
DEFAULT_PUID=$(id -u)
DEFAULT_PGID=$(id -g)
ENV_FILE="$SCRIPT_DIR/.env"
hosts="127.0.0.1 \
local-ne.techbizz.local \
local-us.techbizz.local \
dev-ne.techbizz.local \
dev-us.techbizz.local \
qa-ne.techbizz.local \
qa-us.techbizz.local \
stage-ne.techbizz.local \
stage-us.techbizz.local \
prod-ne.techbizz.local \
prod-us.techbizz.local"

################################ MYSQL ###################################
MYSQL_CONTEXT_PATH=$SCRIPT_DIR/mysql
MYSQL_DOCKER_ENTRY_POINT_INIT_D_PATH=$MYSQL_CONTEXT_PATH/docker-entrypoint-initdb.d
MAIN_DB_NAME=project_db
MAIN_DB_FILE_PATH=$MYSQL_DOCKER_ENTRY_POINT_INIT_D_PATH/main_db.sql
TEST_DB_NAME=project_test_db
TEST_DB_FILE_PATH=$MYSQL_DOCKER_ENTRY_POINT_INIT_D_PATH/test_db.sql

MYSQL_ENTRY_POINT_CREATE_MAIN_DB_CONTENT="CREATE DATABASE IF NOT EXISTS $MAIN_DB_NAME COLLATE 'utf8_general_ci';"
MYSQL_ENTRY_POINT_CREATE_TEST_DB_CONTENT="CREATE DATABASE IF NOT EXISTS $MAIN_DB_NAME COLLATE 'utf8_general_ci';"
#############################################################################

################################ NGINX ###################################
NGINX_EXAMPLE_SITE_PATH=$SCRIPT_DIR/nginx/sites/main-site.conf.example
NGINX_REAL_SITE_PATH=$SCRIPT_DIR/nginx/sites/main-site.conf
##########################################################################
