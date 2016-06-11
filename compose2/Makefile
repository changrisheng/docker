pull:
	docker pull daocloud.io/nginx:1.9.0
	docker pull daocloud.io/php:5.6-fpm
	docker pull daocloud.io/mysql:5.6
	docker pull daocloud.io/redis:3.0
	docker pull daocloud.io/memcached:1.4
	docker pull daocloud.io/node:0.12

dl:
	wget https://github.com/phalcon/cphalcon/archive/1.3.5.tar.gz -O php/cphalcon.tgz
	wget https://pecl.php.net/get/gearman-1.1.2.tgz -O php/gearman.tgz
	wget https://pecl.php.net/get/redis-2.2.7.tgz -O php/redis.tgz
	wget https://pecl.php.net/get/memcached-2.2.0.tgz -O php/memcached.tgz
	wget https://pecl.php.net/get/xdebug-2.3.2.tgz -O php/xdebug.tgz
	wget https://pecl.php.net/get/msgpack-0.5.6.tgz -O php/msgpack.tgz
	wget https://pecl.php.net/get/memcache-2.2.7.tgz -O php/memcache.tgz
	wget https://pecl.php.net/get/xhprof-0.9.4.tgz -O php/xhprof.tgz
	wget https://getcomposer.org/composer.phar -O php/composer.phar

build:
	make build-nginx
	make build-mysql
	make build-php
	make build-redis

build-nginx:
	docker build -t hhxsv5/nginx ./nginx

build-php:
	docker build -t hhxsv5/php ./php

build-mysql:
	docker build -t hhxsv5/mysql ./mysql

build-redis:
	docker build -t hhxsv5/redis ./redis

# build-memcached:
# 	docker build -t hhxsv5/memcached ./memcached

build-node:
	docker build -t hhxsv5/node ./node

build-elasticsearch:
	docker build -t hhxsv5/elasticsearch ./elasticsearch

build-gearman:
	docker build -t hhxsv5/gearman ./gearman

clean:
	docker rmi -f $(shell docker images | grep "<none>" | awk "{print \$3}")
