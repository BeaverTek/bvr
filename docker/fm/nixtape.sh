#!/bin/sh

if [ ! -e /var/www/nixtape/config.php ]; then

    echo "Configuring nixtape"
    cd /var/www/nixtape
    mkdir -p /var/www/nixtape/themes/gnufm/templates_c
    composer install

    chmod g+w -R /var/www/nixtape
    chown :www-data -R /var/www/nixtape

    echo "Running install script"
    php /var/install/nixtape.php
fi
