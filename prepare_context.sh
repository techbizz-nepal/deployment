#!/bin/sh
SCRIPT_DIR=$(dirname "$(realpath "$0")")
#imports
. "$SCRIPT_DIR"/variables.h
. "$SCRIPT_DIR"/mysql.h
. "$SCRIPT_DIR"/docker.h
hosts="127.0.0.1 local-ne.techbizz.local local-us.techbizz.local dev-ne.techbizz.local qa-ne.techbizz.local stage-ne.techbizz.local prod-ne.techbizz.local dev-us.techbizz.local qa-us.techbizz.local stage-us.techbizz.local prod-us.techbizz.local"

if ! [ -f "$SCRIPT_DIR/.env" ]; then
  cp "$SCRIPT_DIR"/.env.example "$SCRIPT_DIR"/.env
fi

if [ "$FIRST_ARG" = "build" ]; then
  create_sql_file_if_not_exist "$MYSQL_ENTRY_POINT_CREATE_MAIN_DB_CONTENT" "$MAIN_DB_FILE_PATH"
  create_sql_file_if_not_exist "$MYSQL_ENTRY_POINT_CREATE_TEST_DB_CONTENT" "$TEST_DB_FILE_PATH"
  docker_build
  docker_up
  exit 0
fi

if [ "$FIRST_ARG" = "up" ]; then
  docker_up
  exit 0
fi

if [ "$FIRST_ARG" = "down" ]; then
  docker_down
  exit 0
fi

# Check if the line already exists in the file
if ! grep -qxF "$hosts" /etc/hosts; then
    # If the line doesn't exist, append it to the file
    echo "$hosts" | sudo tee -a /etc/hosts > /dev/null
    echo "host appended successfully."
    exit 0
else
    # If the line already exists, inform the user
    echo "host already exists in the file."
    exit 0
fi