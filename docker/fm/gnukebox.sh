#!/bin/sh

if [ ! -e /var/www/gnukebox/config.php ]; then

    echo "Configuring gnukebox"
    cd /var/www/gnukebox
    composer install

    chmod g+w -R /var/www/gnukebox
    chown :www-data -R /var/www/gnukebox

    echo "Running install script"
    php /var/install/gnukebox.php
fi
