#!/bin/sh

FIRST_ARG="$1"

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

DOCKER_COMPOSE_FILE_PATH="$SCRIPT_DIR/docker-compose.yaml"

MYSQL_CONTEXT_PATH=$SCRIPT_DIR/mysql
MYSQL_DOCKER_ENTRY_POINT_INIT_D_PATH=$MYSQL_CONTEXT_PATH/docker-entrypoint-initdb.d

MAIN_DB_NAME=project_db
MAIN_DB_FILE_PATH=$MYSQL_DOCKER_ENTRY_POINT_INIT_D_PATH/main_db.sql

TEST_DB_NAME=project_test_db
TEST_DB_FILE_PATH=$MYSQL_DOCKER_ENTRY_POINT_INIT_D_PATH/test_db.sql

MYSQL_ENTRY_POINT_CREATE_MAIN_DB_CONTENT="CREATE DATABASE IF NOT EXISTS $MAIN_DB_NAME COLLATE 'utf8_general_ci';"
MYSQL_ENTRY_POINT_CREATE_TEST_DB_CONTENT="CREATE DATABASE IF NOT EXISTS $MAIN_DB_NAME COLLATE 'utf8_general_ci';"