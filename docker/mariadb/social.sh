#!/bin/sh

#       # grant usage on *.* to '${SOCIAL_USER}'@'%' identified by '${SOCIAL_PASSWORD}'; \

echo "create database if not exists \`${SOCIAL_DB}\`; \
      create user '${SOCIAL_USER}'@'%' identified by '${SOCIAL_PASSWORD}'; \
      grant all on \`${SOCIAL_DB}\`.* to '${SOCIAL_USER}'@'%'; \
      flush privileges;" \
    | mysql -uroot -p"${MYSQL_ROOT_PASSWORD}"
