FROM daocloud.io/library/nginx:1.11.0

ADD  nginx.conf /etc/nginx/nginx.conf
ADD  php_handler.conf /etc/nginx/php_handler.conf
ADD  conf.d/* /etc/nginx/conf.d/
RUN  mkdir /opt/www && mkdir /var/log/nginx -p
RUN  touch /var/log/nginx/access.log
RUN  touch /var/log/nginx/error.log
RUN  chown -R www-data.www-data /opt/www /var/log/nginx

EXPOSE 80
VOLUME ["/opt"]

