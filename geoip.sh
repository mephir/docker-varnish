#!/bin/bash

set -e

echo "Compiling and installing GeoIP updater"

mkdir -p /root/tmp

apk --no-cache add git make autoconf automake libtool zlib-dev curl curl-dev

cd /root/tmp
git clone https://github.com/maxmind/geoipupdate.git
cd geoipupdate/
./bootstrap
./configure
make
make install

echo "Cleanup"
apk del git make autoconf automake libtool zlib-dev curl-dev
rm -rf /root/tmp

echo "Downloading latest GeoIP database"
geoipupdate
