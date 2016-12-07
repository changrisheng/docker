FROM daocloud.io/php:5.6-fpm

ADD sources.list /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    vim \
    lrzsz \
    libjpeg-dev \
    libpng12-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libmemcached-dev \
    libicu-dev \
    mysql-client \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install iconv \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install intl \
    && docker-php-ext-install opcache \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install zip \
    && docker-php-ext-install mbstring

# PHP config
ADD php.ini /usr/local/etc/php/php.ini
ADD php-fpm.conf /usr/local/etc/php-fpm.conf

# PHP extension
COPY redis.tgz /home/redis.tgz
COPY memcached.tgz /home/memcached.tgz
COPY memcache.tgz /home/memcache.tgz
COPY opcache.ini /home/opcache.ini

RUN cat /home/opcache.ini >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini

RUN pecl install /home/redis.tgz && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
    && pecl install /home/memcached.tgz && echo "extension=memcached.so" > /usr/local/etc/php/conf.d/memcached.ini \
    && pecl install /home/memcache.tgz && echo "extension=memcache.so" > /usr/local/etc/php/conf.d/memcache.ini

# Install composer
RUN /usr/local/bin/php -r "readfile('https://getcomposer.org/installer');" > /root/composer-setup.php
RUN /usr/local/bin/php /root/composer-setup.php --install-dir="/root" --filename="composer.phar"
RUN rm -f /root/composer-setup.php
RUN mv /root/composer.phar /usr/local/bin/composer


# Write Permission
RUN usermod -u 1000 www-data

# Create directory
RUN mkdir /docker/www -p
RUN mkdir /docker/log/php -p

RUN chown -R www-data.www-data /docker/www
RUN chown -R www-data.www-data /docker/log/php

CMD ["php-fpm"]