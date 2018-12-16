#!/bin/bash

if [ -z "$SLAVE" ]; then
    SLAVE="127.0.0.1"
fi

/usr/bin/memcached -m 64 -p 11211 -u memcache -x $SLAVE
