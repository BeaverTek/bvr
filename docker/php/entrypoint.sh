#!/bin/sh

for script in /var/entrypoint.d/*.sh; do
    $script
done

exec php-fpm
