# Docker guideline for PHP Developer

## Images

- Nginx: `nginx:1.10.1`

- PHP-FPM: `php:{5.6/7.3}-fpm-stretch`; with extensions: `OPcache` `Redis` `Memcache` `PDO` `Swoole`; with command: `Composer`

- Redis: `redis:3.0`

- SSDB: `https://github.com/ideawu/ssdb/archive/master.zip`

- MySQL: `mysql:5.7.23`

- PostgrelSQL: `postgres:11.2`

- Grafana: `grafana:5.4.3`

## Steps

1. Install Docker

    - [Mac](https://docs.docker.com/docker-for-mac/install/)

    - [Linux](https://docs.docker.com/install/linux/docker-ce/debian/)

    - [Windows](https://docs.docker.com/docker-for-windows/install/)

2. Modify the directory in file `docker-compose.yml`, default mount `~/Documents/docker/www` `~/Documents/docker/log`

    ```Bash
    # On the host
    mkdir -p ~/Documents/docker/log/php7 ~/Documents/docker/log/php ~/Documents/docker/log/nginx 
    ```

3. Build images, create containners, and start them:

    ```Bash
    docker-compose up -d
    ```

4. Maybe you need to do something:

    - Modify Nginx configuration in `./nginx/conf.d`, the default configuration for Laravel and LaravelS already exists

    - Bind domain into your host machine. Linux/Mac: `/etc/hosts`, Windows: `C:\Windows\System32\drivers\etc\hosts`

    - Run `docker-compose restart`
5. I WANT TO CONNECT FROM A CONTAINER TO A SERVICE ON THE HOST
    
    The host has a changing IP address (or none if you have no network access). From 18.03 onwards our recommendation is to connect to the special DNS name host.docker.internal, which resolves to the internal IP address used by the host. This is for development purpose and will not work in a production environment outside of Docker Desktop for Mac.   
