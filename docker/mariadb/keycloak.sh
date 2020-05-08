#!/bin/sh

echo "KEYCLOAK ${DB_DATABASE}"

echo "create database if not exists \`${DB_DATABASE}\`; \
      create user if not exists '${DB_USER}'@'%' identified by '${DB_PASSWORD}'; \
      grant all on \`${DB_DATABASE}\`.* to '${DB_USER}'@'%'; \
      flush privileges;" \
    | mysql -uroot -p"${MYSQL_ROOT_PASSWORD}"
