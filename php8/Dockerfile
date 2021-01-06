FROM php:8.0-fpm-buster

ARG LIBRDKAFKA_VERSION=1.5.3
# TODO
# ARG RDKAFKA_VERSION=5.0.0
ARG INOTIFY_VERSION=3.0.0
ARG MONGODB_VERSION=1.9.0
ARG MCRYPT_VERSION=1.0.4
ARG MEMCACHED_VERSION=3.1.5
ARG REDIS_VERSION=5.3.2
ARG SWOOLE_VERSION=4.5.10

# Aliyun mirror
ADD sources.list /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    vim \
    wget \
    lrzsz \
    curl \
    telnet \
    iputils-ping \
    net-tools \
    tcpdump \
    strace \
    smem \
    gdb \
    lsof \
    libjpeg-dev \
    libpng-dev \
    zlib1g-dev \
    libzip-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libsasl2-dev \
    libmemcached-dev \
    libicu-dev \
    libonig-dev \
    libgmp3-dev \
    libzip4 \
    procps \
    zip \
    unzip \
    git \
    && docker-php-ext-install gmp \
    pdo_mysql \
    iconv \
    intl \
    pcntl \
    opcache \
    bcmath \
    mbstring \
    && pecl update-channels \
    # && git clone --depth 1 --branch v$LIBRDKAFKA_VERSION https://github.com/edenhill/librdkafka.git /tmp/librdkafka && cd /tmp/librdkafka && ./configure && make -j$(nproc) && make install && cd - && pecl install rdkafka-$RDKAFKA_VERSION && docker-php-ext-enable rdkafka && rm -rf /tmp/librdkafka \
    && docker-php-ext-install gd \
    && pecl install inotify-$INOTIFY_VERSION && docker-php-ext-enable inotify \
    && pecl install mongodb-$MONGODB_VERSION && docker-php-ext-enable mongodb \
    && pecl install mcrypt-$MCRYPT_VERSION && docker-php-ext-enable mcrypt \
    && pecl install memcached-$MEMCACHED_VERSION && docker-php-ext-enable memcached \
    && pecl install redis-$REDIS_VERSION && docker-php-ext-enable redis

# PHP config
ADD php.ini /usr/local/etc/php/php.ini
ADD php-fpm.conf /usr/local/etc/php-fpm.conf

# OPcache
COPY opcache.ini /home/opcache.ini
RUN cat /home/opcache.ini >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini

# Swoole
RUN apt-get install -y libpcre3 libpcre3-dev libssl-dev \
    && pecl install --onlyreqdeps --nobuild swoole-$SWOOLE_VERSION \
    && cd "$(pecl config-get temp_dir)/swoole" && phpize && ./configure --enable-openssl && make -j$(nproc) && make install && cd - \
    && docker-php-ext-enable swoole

# Install composer
COPY composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

# Aliyun mirror
RUN /usr/local/bin/composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

# Write Permission
RUN usermod -u 1000 www-data

# Create directory
RUN mkdir /docker/www -p && mkdir /docker/log/php8 -p

RUN chown -R www-data.www-data /docker/www /docker/log/php8

RUN touch /docker/log/php8/php_errors.log && chmod 777 /docker/log/php8/php_errors.log

RUN rm -rf /var/lib/apt/lists/*

CMD ["php-fpm"]