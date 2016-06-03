# NodeJS
# Base on Ubuntu 14.04
# Build: docker build -t hhxsv5/ubuntu-node:latest -f ./Dockerfile-NodeJS .
# Run: docker run -it --name ubuntu-node -p 80:80 -p 443:443 -p 3306:3306 -p 11211:11211 -p 6379:6379 -v ~/Documents/www:/home/www hhxsv5/ubuntu-node:latest sh -c '/root/start.sh && /bin/bash'
# VERSION 0.0.1
FROM ubuntu:trusty
ENV CODENAME=trusty
MAINTAINER Dave Xie <hhxsv5@sina.com>
LABEL Description="This image contains nodejs environment" Vendor="CUIT Products" Version="1.0"
WORKDIR /root
RUN \
    apt-get install -y curl && \
    curl -fsSL "http://mirrors.163.com/.help/sources.list.${CODENAME}" -o /etc/apt/sources.list && \
    curl -fsSL http://nginx.org/keys/nginx_signing.key | sudo apt-key add - && \
    echo "deb http://nginx.org/packages/ubuntu/ ${CODENAME} nginx\ndeb-src http://nginx.org/packages/ubuntu/ ${CODENAME} nginx" >> /etc/apt/sources.list && \
    apt-get update && apt-get upgrade -y && \
    #curl -sL "https://deb.nodesource.com/setup_4.x" | sudo -E bash - && \
    curl -sL "https://deb.nodesource.com/setup_5.x" | sudo -E bash - && \
    apt-get install -y nodejs && \
    apt-get install wget vim -y && \
    apt-get clean && apt-get autoclean && \
    echo "#bootstrap command" > /root/start.sh && \
    chmod +x /root/start.sh

EXPOSE 80 443 3306 11211 6379
#CMD ["/bin/bash", "/root/start.sh"]