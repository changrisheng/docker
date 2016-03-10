# Nginx for PHP developer
# Base on Ubuntu 14.04
# VERSION 0.0.1
FROM ubuntu:trusty
ENV CODENAME=trusty
MAINTAINER Dave Xie <hhxsv5@sina.com>
LABEL Description="This image contains nginx and php5-fpm" Vendor="CUIT Products" Version="1.0"
WORKDIR /root
RUN \
    apt-get install -y curl && \
    curl -fsSL "http://mirrors.163.com/.help/sources.list.${CODENAME}" -o /etc/apt/sources.list && \
    curl -fsSL http://nginx.org/keys/nginx_signing.key | sudo apt-key add - && \
    echo "deb http://nginx.org/packages/ubuntu/ ${CODENAME} nginx\ndeb-src http://nginx.org/packages/ubuntu/ ${CODENAME} nginx" >> /etc/apt/sources.list && \
    apt-get update && apt-get upgrade -y && \
    apt-get install wget vim -y && \
    apt-get install nginx -y && \
    apt-get install php5-cli php5-fpm php5-curl php5-gd php5-mysql php5-mcrypt php5-memcache php5-memcached php5-redis -y && \
    apt-get install memcached redis-server -y && \
    apt-get clean && apt-get autoclean && \
    mkdir /var/log/php && \
    sed -i -e "s/^;cgi.fix_pathinfo=1/cgi.fix_pathinfo = 0/g" /etc/php5/cli/php.ini /etc/php5/fpm/php.ini && \
    sed -i -e "s/^error_reporting\s*=.*/error_reporting = E_ALL/g" /etc/php5/cli/php.ini /etc/php5/fpm/php.ini && \
    sed -i -e "s/^display_errors\s*=.*/display_errors = On/g" /etc/php5/cli/php.ini /etc/php5/fpm/php.ini && \
    sed -i -e "s/^display_startup_errors\s*=.*/display_startup_errors = On/g" /etc/php5/cli/php.ini /etc/php5/fpm/php.ini && \
    sed -i -e "s/^;*error_log\s*=\s*syslog/;#error_log = syslog/g" /etc/php5/cli/php.ini /etc/php5/fpm/php.ini && \
    sed -i -e "s/^;*error_log\s*=.*/error_log=\/var\/log\/php\/php_error.log/g" /etc/php5/cli/php.ini /etc/php5/fpm/php.ini && \
    sed -i -e "s/;*date.timezone\s*=.*/date.timezone = UTC/" /etc/php5/cli/php.ini /etc/php5/fpm/php.ini && \
    sed -i -e "s/;*error_log\s*=.*/error_log = \/var\/log\/php\/php5-fpm.log/g" /etc/php5/fpm/php-fpm.conf && \
    #sed -i -e "s/;*access.log\s*=.*/access.log = \/var\/log\/php\/\$pool.access.log/g" /etc/php5/fpm/pool.d/www.conf && \
    sed -i -e "s/user\s*nginx;/user www-data;/g" /etc/nginx/nginx.conf && \
    chown -R www-data:www-data /var/log/nginx && \
    #sed -i -e "/#\s*deny access/i\    include php_handler;" /etc/nginx/conf.d/default.conf && \
    #sed -i -e "s/\s*#*\s*access_log.*/    access_log \/var\/log\/nginx\/\$server_name.access.log  main;/g" /etc/nginx/conf.d/default.conf && \
    #sed -i -e "s/\<index\s\s*.*/index index\.php index\.html index\.htm;/" /etc/nginx/conf.d/default.conf && \
    #sed -i -e "0,/root\s*\/usr\/share\/nginx\/html;/{/root\s*\/usr\/share\/nginx\/html;/d}" /etc/nginx/conf.d/default.conf && \
    #sed -i -e "s/server_name\s*localhost;/server_name localhost;\\n    root \/home\/www;/g" /etc/nginx/conf.d/default.conf && \
    echo "opcache.memory_consumption=128\nopcache.interned_strings_buffer=8\nopcache.max_accelerated_files=100000\nopcache.fast_shutdown=1\nopcache.enable=1\nopcache.enable_cli=1\nopcache.validate_timestamps=1\nopcache.revalidate_freq=2\nopcache.revalidate_path=1\nopcache.save_comments=1\nopcache.consistency_checks=0\nopcache.force_restart_timeout=180\nopcache.log_verbosity_level=2\nopcache.use_cwd=0\nopcache.huge_code_pages=1" >> /etc/php5/mods-available/opcache.ini && \
    echo "vm.nr_hugepages=512" >> /etc/sysctl.conf && \
    sysctl -p && \
    cat /proc/meminfo | grep Huge && \
    echo "server {\n    listen 80;\n    server_name localhost;\n    root /home/www;\n    access_log /var/log/nginx/\$server_name.access.log  main;\n    include php_handler;\n}" > /etc/nginx/conf.d/default.conf && \
    echo "location / {\n    index index.php index.html index.htm;\n    #try_files \$uri \$uri/ /index.php?\$args;#For Yii\n}\nlocation ~ \\.php\$ {\n    fastcgi_split_path_info ^(.+\\.php)(/.+)\$;\n    #fastcgi_pass   127.0.0.1:9000;\n    fastcgi_pass   unix:/var/run/php5-fpm.sock;\n    fastcgi_index  index.php;\n    fastcgi_param  SCRIPT_FILENAME    \$document_root\$fastcgi_script_name;\n    include        fastcgi_params;\n}" > /etc/nginx/php_handler && \
    echo "/etc/init.d/php5-fpm start\n/etc/init.d/nginx start\n#/etc/init.d/memcached start\n#/etc/init.d/redis-server start" > /root/start.sh && \
    chmod +x /root/start.sh

EXPOSE 80 443
#CMD ["/bin/bash", "/root/start.sh"]