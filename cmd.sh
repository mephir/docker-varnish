#!/bin/bash

set -e

for name in VARNISH_BACKEND_PORT VARNISH_BACKEND_IP
do
    eval value=\$$name
    sed -i "s|\${${name}}|${value}|g" /etc/varnish/default.vcl
done

# Start varnish and log
varnishd -f /etc/varnish/default.vcl -s malloc,${VARNISH_CACHE_SIZE:-150M} -l ${VARNISH_SHMLOG_SIZE:-80M} -a 0.0.0.0:${VARNISH_PORT}
varnishlog
