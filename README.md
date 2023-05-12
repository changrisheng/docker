# Docker guideline for PHP Developer

## Images

- Nginx: `nginx:1.17.2`

- PHP-FPM: `php:5.6-fpm-stretch` `php7.4:based on amazonlinux:2` `php:8.0-fpm-buster`

```ini
[PHP Modules]
apcu
bcmath
bz2
calendar
Core
ctype
curl
date
dom
exif
fileinfo
filter
ftp
gd
gettext
gmp
hash
iconv
inotify
intl
json
libxml
mbstring
mcrypt
mongodb
mysqli
mysqlnd
openssl
pcntl
pcov
pcre
PDO
pdo_mysql
pdo_sqlite
Phar
posix
rdkafka
readline
redis
Reflection
session
shmop
SimpleXML
sockets
sodium
SPL
sqlite3
standard
swoole
sysvmsg
sysvsem
sysvshm
tokenizer
xml
xmlreader
xmlwriter
xsl
Zend OPcache
zip
zlib

[Zend Modules]
Zend OPcache
```

- Composer 2

- Redis: `redis:5.0`

- SSDB: `https://github.com/ideawu/ssdb/archive/master.zip`

- MySQL: `mysql:5.7.28`

- PostgrelSQL: `postgres:11.2`

- Prometheus: `prometheus:v2.30.3`

- Grafana: `grafana:7.5.11`

- Zookeeper: `wurstmeister/zookeeper`

- Kafka: `wurstmeister/kafka:2.11-1.1.1`

- Kafdrop: `obsidiandynamics/kafdrop`

- Kafka Manager: `hlebalbau/kafka-manager:stable`

## Steps

1.Install Docker
- [Mac](https://docs.docker.com/docker-for-mac/install/)
- [Linux](https://docs.docker.com/install/linux/docker-ce/debian/)
- [Windows](https://docs.docker.com/docker-for-windows/install/)

2.Modify the directory in file `docker-compose.yml`, default mount `~/Documents/docker/www` `~/Documents/docker/log`

```bash
# On the host
mkdir -p ~/Documents/docker/log/php7 ~/Documents/docker/log/php ~/Documents/docker/log/nginx 
```

3.Build images, create containners, and start them:

```bash
docker-compose up -d
```

4.Maybe you need to do something:
- Modify Nginx configuration in `./nginx/conf.d`, the default configuration for Laravel and LaravelS already exists
- Bind domain into your host machine. Linux/Mac: `/etc/hosts`, Windows: `C:\Windows\System32\drivers\etc\hosts`
- Run `docker-compose restart`

5.[I WANT TO CONNECT FROM A CONTAINER TO A SERVICE ON THE HOST](https://docs.docker.com/docker-for-mac/networking/#use-cases-and-workarounds)
The host has a changing IP address (or none if you have no network access). From 18.03 onwards our recommendation is to connect to the special DNS name `host.docker.internal`, which resolves to the internal IP address used by the host. This is for development purpose and will not work in a production environment outside of Docker Desktop for Mac.   
