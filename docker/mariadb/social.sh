#!/bin/sh

echo "create database \`${SOCIAL_DB}\`; \
      create user '${SOCIAL_USER}' identified by '${SOCIAL_PASSWORD}'; \
      grant usage on *.* to '${SOCIAL_USER}'@127.0.0.1 identified by '${SOCIAL_PASSWORD}'; \
      grant all privileges on \`${SOCIAL_DB}\`.* to '$SOCIAL_USER'@127.0.0.1; \
      flush privileges;" \
    | mysql -uroot -p"${MYSQL_ROOT_PASSWORD}"
