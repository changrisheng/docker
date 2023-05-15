FROM amazonlinux:2

LABEL maintainers="hhxsv5"

ARG LIBRDKAFKA_VERSION=1.8.2
ARG RDKAFKA_VERSION=6.0.1
ARG INOTIFY_VERSION=3.0.0
ARG MONGODB_VERSION=1.13.0
ARG MCRYPT_VERSION=1.0.5
ARG REDIS_VERSION=5.3.7
ARG SWOOLE_VERSION=4.5.11
ARG APCU_VERSION=5.1.21

# Install packages
RUN amazon-linux-extras enable php7.4 && yum clean metadata && yum install -y \
    # System packages
    tar \
    gzip \
    unzip \
    iproute \
    net-tools \
    telnet \
    procps \
    gcc \
    gcc-c++ \
    make \
    libmcrypt-devel \
    openssl-devel \
    # Develop packages
    # wget \
    # lrzsz \
    # tcpdump \
    strace \
    # gdb \
    # lsof \
    # git-core \
    # PHP packages
    php \
    php-cli \
    php-devel \
    php-bcmath \
    php-fpm \
    php-gd \
    php-gmp \
    php-intl \
    php-json \
    php-mysqlnd \
    php-mbstring \
    php-pear \
    php-pdo \
    php-sodium \
    php-xml \
    php-opcache \
    # PHP extensions
    && pecl update-channels \
    && curl -L -o /tmp/librdkafka.zip https://github.com/edenhill/librdkafka/archive/refs/tags/v$LIBRDKAFKA_VERSION.zip && unzip -d /tmp /tmp/librdkafka.zip && cd /tmp/librdkafka-$LIBRDKAFKA_VERSION && ./configure && make -j$(nproc) && make install && cd - && rm -rf /tmp/librdkafka* \
    && pecl install rdkafka-$RDKAFKA_VERSION && echo 'extension=rdkafka.so' > /etc/php.d/rdkafka.ini \
    && pecl install apcu-$APCU_VERSION \
    && pecl install pcov && echo 'extension=pcov.so' > /etc/php.d/pcov.ini \
    && pecl install inotify-$INOTIFY_VERSION && echo 'extension=inotify.so' > /etc/php.d/inotify.ini \
    && pecl install mongodb-$MONGODB_VERSION && echo 'extension=mongodb.so' > /etc/php.d/mongodb.ini \
    && pecl install mcrypt-$MCRYPT_VERSION && echo 'extension=mcrypt.so' > /etc/php.d/mcrypt.ini \
    && pecl install redis-$REDIS_VERSION && echo 'extension=redis.so' > /etc/php.d/redis.ini \
    && pecl install --configureoptions 'enable-openssl="yes"' swoole-$SWOOLE_VERSION && echo 'extension=swoole.so' > /etc/php.d/swoole.ini \
    # Upgrade packages
    && yum update -y curl util-linux expat systemd ncurses vim-data vim-minimal ca-certificates \
    # Clean packages
    && (pecl clear-cache || true) && yum erase -y \
    tar \
    gcc \
    gcc-c++ \
    automake \
    autoconf \
    make \
    pkgconfig \
    php-pear \
    perl \
    httpd \
    httpd-filesystem \
    httpd-tools \
    apr \
    apr-util \
    apr-util-bdb \
    generic-logos-httpd \
    && yum list installed | grep "\-devel" | (xargs yum erase -y || true) \
    && yum clean all \
    && rm -rf /var/cache/* /tmp/* /var/tmp/* /usr/lib/php/doc/* /usr/lib/php/test/* /usr/share/doc/* /usr/share/tests/* \
    # Fix bash settings
    && cp /etc/skel/.bashrc /etc/skel/.bash_profile /root/ \
    && echo "alias vim='vi'" >> /root/.bashrc \
    && mkdir -p /var/log/php /var/log/php-fpm

# Copy files
COPY .vimrc /root/.vimrc
COPY .vimrc /root/.exrc
COPY php.ini /etc/php.ini
COPY php-fpm.conf /etc/php-fpm.conf
COPY php-ext-opcache.ini /etc/php.d/10-opcache.ini
COPY php-ext-apcu.ini /etc/php.d/apcu.ini
COPY composer.phar /usr/local/bin/composer

# Composer config
RUN update-ca-trust \
    && /usr/local/bin/composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ \
    && /usr/local/bin/composer config -g allow-plugins false

CMD ["php-fpm", "-F"]