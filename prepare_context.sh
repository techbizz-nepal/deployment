#!/bin/sh
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
#imports
. $SCRIPT_DIR/variables.h
. $SCRIPT_DIR/mysql.h
. $SCRIPT_DIR/docker.h

if ! [ -f "$SCRIPT_DIR/.env" ]; then
  cp $SCRIPT_DIR/.env.example $SCRIPT_DIR/.env
fi

if [ "$FIRST_ARG" = "build" ]; then
  create_sql_file_if_not_exist "$MYSQL_ENTRY_POINT_CREATE_MAIN_DB_CONTENT" "$MAIN_DB_FILE_PATH"
  create_sql_file_if_not_exist "$MYSQL_ENTRY_POINT_CREATE_TEST_DB_CONTENT" "$TEST_DB_FILE_PATH"
  docker_build
  docker_up
fi

if [ "$FIRST_ARG" = "up" ]; then
  docker_up
fi

if [ "$FIRST_ARG" = "down" ]; then
  docker_down
fi