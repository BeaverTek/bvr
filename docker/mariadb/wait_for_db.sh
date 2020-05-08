#!/bin/sh

while ! mysqladmin ping --silent -hdb -uroot -p${MYSQL_ROOT_PASSWORD};
do
    echo "Waiting for DB..."
    sleep 3
done
