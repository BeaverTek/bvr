#!/bin/sh

echo "create database if not exists \`${GNUFM_DBNAME}\`; \
      create user if not exists '${GNUFM_USERNAME}'@'%' identified by '${GNUFM_PASSWORD}'; \
      grant all on \`${GNUFM_DBNAME}\`.* to '${GNUFM_USERNAME}'@'%'; \
      flush privileges;" \
    | mysql -uroot -p"${MYSQL_ROOT_PASSWORD}"
