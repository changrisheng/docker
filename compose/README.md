# Docker guideline for PHP Developer

## Images

- Nginx: `nginx:1.10.1`

- PHP-FPM: `php:5.6-fpm`; with extensions: `Opcache`, `Redis`, `Memcache`, `Memcached`, `Swoole`; with command: `Composer`

- Redis: `redis:3.0`

- SSDB: `https://github.com/ideawu/ssdb/archive/master.zip`

## Steps

1. Install docker

    - [Mac](https://download.docker.com/mac/stable/Docker.dmg)

    - [Linux](http://docs.docker.com/engine/installation/linux/)

    - [Windows](https://download.docker.com/win/stable/InstallDocker.msi)

2. Build images & create containners:

    ```Bash
    docker-compose up
    ```
3. Start containners:

    ```Bash
    docker-compose start
    ```

4. Maybe you need to bind host to `127.0.0.1`, then `docker-compose restart`