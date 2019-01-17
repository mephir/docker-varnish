#!/bin/bash

set -e

apk --no-cache add varnish-dev wget make ca-certificates libmaxminddb libmaxminddb-dev automake autoconf libtool py-docutils git gettext

mkdir -p /root/tmp

echo "Compiling and installing varnish modules"
cd /root/tmp
wget https://download.varnish-software.com/varnish-modules/varnish-modules-0.15.0.tar.gz
tar -zxvf varnish-modules-0.15.0.tar.gz
cd varnish-modules-0.15.0
./configure
make
make install
cd /

echo "Compiling and installing geoip module"
cd /root/tmp
git clone --recursive -b oldstable https://github.com/fgsch/libvmod-geoip2.git
cd libvmod-geoip2/
./autogen.sh
./configure
make
make install

echo "Cleanup"
apk del varnish-dev wget make libmaxminddb-dev automake autoconf libtool py-docutils git gettext
rm -rf /root/tmp
