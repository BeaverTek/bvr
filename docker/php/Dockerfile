FROM php:fpm-alpine

RUN apk update && apk add gettext-dev icu-dev zlib-dev libpng-dev gmp-dev mariadb-dev

ARG exts=" bcmath exif gd gettext gmp intl mysqli opcache pdo pdo_mysql"

RUN apk add --virtual .phpize-deps $PHPIZE_DEPS \
        && rm -rf /usr/share/php7 \
        && rm -rf /tmp/* \
        && apk del .phpize-deps

RUN docker-php-ext-install ${exts}

WORKDIR /var/www/social

# RUN . /var/social.env

# RUN echo FOOO $SOCIAL_DOMAIN

# RUN php ./scripts/install_cli.php -s $SOCIAL_DOMAIN #
