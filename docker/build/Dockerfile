FROM php:8.1-fpm

# Install node
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get update
RUN apt-get install -y zlib1g-dev git zip unzip libzip-dev nodejs netcat-openbsd \
    libfreetype6-dev libwebp-dev libjpeg-dev libpng-dev libxml2-dev

RUN apt-get install -y bash mariadb-client procps iputils-ping net-tools supervisor

# Install composer
RUN curl https://getcomposer.org/installer --output composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# PHP Extensions
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ --with-webp=/usr/include/
RUN docker-php-ext-install gd
RUN docker-php-ext-enable gd

RUN docker-php-ext-install bcmath zip pdo pdo_mysql soap xml intl pcntl
RUN docker-php-ext-install opcache

RUN apt-get install -y libldap2-dev
RUN docker-php-ext-install ldap

RUN apt-get install -y libpq-dev
RUN docker-php-ext-install pdo_pgsql pgsql

RUN pecl install mongodb && docker-php-ext-enable mongodb

RUN apt-get install -y libc-client-dev libkrb5-dev
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-install imap
RUN docker-php-ext-enable imap

RUN apt-get update
RUN apt-get install -y pngquant jpegoptim libtidy-dev

RUN docker-php-ext-install tidy

WORKDIR /var/www

# Supervisor
RUN apt-get install -y nano supervisor systemctl
COPY ./docker/config/supervisor.conf /etc/supervisor/conf.d/app.conf
RUN systemctl restart supervisor

# Crontab
RUN apt-get install -y cron
RUN crontab -l | { cat; echo "*/1 * * * * php /var/www/bin/console oro:cron --env=prod > /dev/null"; } | crontab -

# XDebug, uncomment after oro installation
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

RUN pecl install apcu
RUN docker-php-ext-enable apcu

RUN apt-get install -y acl

EXPOSE 9000
CMD ["php-fpm"]
