#!/bin/sh

if [ ! -e /var/www/social/config.php ]; then
    echo "Installing GNU social"
    mkdir -p /var/www/social/file/avatar

    chown -R www-data:www-data /var/www/social

    php /var/www/social/scripts/install_cli.php --server="${SOCIAL_DOMAIN}" --sitename="${SOCIAL_SITENAME}" \
        --host=db --fancy=yes --database="${SOCIAL_DB}" \
        --username="${SOCIAL_USER}" --password="${SOCIAL_PASSWORD}" \
        --admin-nick="${SOCIAL_ADMIN_NICK}" --admin-pass="${SOCIAL_ADMIN_PASSWORD}" || exit 1

    echo "GNU social is installed"
fi
