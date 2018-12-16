FROM ubuntu:16.04

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update

RUN apt-get -y upgrade

RUN apt-get -y install wget perl libsasl2-2 libevent-2.0-5

RUN wget https://launchpad.net/~niedbalski/+archive/ubuntu/memcached-repcached/+files/memcached_1.4.14-0ubuntu10repcache3_amd64.deb

RUN dpkg -i "memcached_1.4.14-0ubuntu10repcache3_amd64.deb"

COPY entrypoint.sh /

EXPOSE 11211

EXPOSE 11212

ENTRYPOINT ["/entrypoint.sh"]
[root@srv-mvn-cl-01 repcached]# cat entrypoint.sh
#!/bin/bash

if [ -z "$SLAVE" ]; then
    SLAVE="127.0.0.1"
fi

/usr/bin/memcached -m 64 -p 11211 -u memcache -x $SLAVE
