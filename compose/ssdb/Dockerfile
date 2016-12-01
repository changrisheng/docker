FROM daocloud.io/debian:8

ADD sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y vim lrzsz git wget unzip make autoconf g++
RUN wget --no-check-certificate https://github.com/ideawu/ssdb/archive/master.zip \
    && unzip master \
    && cd ssdb-master \
    && make \
    && make install \
    && sed -i "s/ip: 127.0.0.1/ip: 0.0.0.0/" /usr/local/ssdb/ssdb.conf

CMD ["/usr/local/ssdb/ssdb-server", "/usr/local/ssdb/ssdb.conf", "-s", "restart"]