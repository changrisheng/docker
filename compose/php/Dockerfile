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

# Swoole
RUN apt-get install -y libpcre3 libpcre3-dev libssl-dev
COPY swoole.tar.gz /home/swoole.tar.gz
RUN mkdir /home/swoole
RUN tar -zvxf /home/swoole.tar.gz -C /home/swoole --strip-components 1
RUN cd /home/swoole; phpize; ./configure --enable-openssl; make; make install
COPY swoole.ini /home/swoole.ini
RUN cat /home/swoole.ini > /usr/local/etc/php/conf.d/swoole.ini

# Install composer
COPY composer.phar /usr/local/bin/composer

# Write Permission
RUN usermod -u 1000 www-data

# Create directory
RUN mkdir /docker/www -p
RUN mkdir /docker/log/php -p

RUN chown -R www-data.www-data /docker/www /docker/log/php

RUN touch /docker/log/php/php_errors.log && chmod 777 /docker/log/php/php_errors.log

CMD ["php-fpm"]