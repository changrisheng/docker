FROM daocloud.io/php:5.6-fpm-jessie

ADD sources.list /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    vim \
    lrzsz \
    libjpeg-dev \
    libpng12-dev \
    zlib1g-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libsasl2-dev \
    libmemcached-dev \
    libicu-dev \
    mysql-client \
    libgmp-dev \
    libgmp3-dev \
    libtidy-dev \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install iconv \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install intl \
    && docker-php-ext-install opcache \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install zip \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install gmp \
    && docker-php-ext-install tidy \
    && pecl install redis && docker-php-ext-enable redis \
    && pecl install memcached && docker-php-ext-enable memcached \
    && docker-php-ext-install mbstring

RUN ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h

# PHP config
ADD php.ini /usr/local/etc/php/php.ini
ADD php-fpm.conf /usr/local/etc/php-fpm.conf

# OPcache
COPY opcache.ini /home/opcache.ini
RUN cat /home/opcache.ini >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini

# Swoole
RUN apt-get install -y libpcre3 libpcre3-dev libssl-dev
COPY swoole.tar.gz /home/swoole.tar.gz
RUN mkdir /home/swoole
RUN tar -zvxf /home/swoole.tar.gz -C /home/swoole --strip-components 1
RUN cd /home/swoole; phpize; ./configure --enable-openssl; make; make install; docker-php-ext-enable swoole

# Install composer
COPY composer.phar /usr/local/bin/composer

# Chinese mirror
RUN /usr/local/bin/composer config -g repo.packagist composer https://packagist.laravel-china.org

# Write Permission
RUN usermod -u 1000 www-data

# Create directory
RUN mkdir /docker/www -p
RUN mkdir /docker/log/php -p

RUN chown -R www-data.www-data /docker/www /docker/log/php

RUN touch /docker/log/php/php_errors.log && chmod 777 /docker/log/php/php_errors.log

CMD ["php-fpm"]