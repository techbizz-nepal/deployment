#!/bin/sh

write_sql_script_content_to_file() {
  echo $1 | tee $2 >/dev/null
}

create_sql_file_if_not_exist() {
  if [ ! -f $2 ]; then
    touch $2
    write_sql_script_content_to_file "$1" "$2"
  fi
}