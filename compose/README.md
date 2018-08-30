# Docker guideline for PHP Developer

## Images

- Nginx: `nginx:1.10.1`

- PHP-FPM: `php:7.1-fpm-jessie`; with extensions: `Opcache` `Redis` `Memcache` `PDO` `Swoole`; with command: `Composer`

- Redis: `redis:3.0`

- SSDB: `https://github.com/ideawu/ssdb/archive/master.zip`

- MySQL: `mysql:5.7.23`

## Steps

1. Install Docker

    - [Mac](https://download.docker.com/mac/stable/Docker.dmg)

    - [Linux](http://docs.docker.com/engine/installation/linux/)

    - [Windows](https://download.docker.com/win/stable/InstallDocker.msi)

2. Modify the directory in file `docker-compose.yml`, default mount `~/Documents/docker/www` `~/Documents/docker/log`

3. Build images, create containners, and start them:

    ```Bash
    docker-compose up -d
    ```

3. Maybe you need to something:

    - Modify Nginx configuration, the default configuration for Laravel and LaravelS already exists

    - Bind domain into your host machine. Linux/Mac: `/etc/hosts`, Windows: `C:\Windows\System32\drivers\etc\hosts`

    - Run `docker-compose restart`