#!/bin/bash

set -e

apk --no-cache add varnish-dev wget python make ca-certificates

mkdir -p /root/tmp
cd /root/tmp
wget https://download.varnish-software.com/varnish-modules/varnish-modules-0.12.1.tar.gz
tar -zxvf varnish-modules-0.12.1.tar.gz
cd varnish-modules-0.12.1
./configure
make
make install
cd /

apk del varnish-dev wget python make ca-certificates
rm -rf /root/tmp