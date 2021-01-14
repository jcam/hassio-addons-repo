#!/bin/bash

rm -rf /usr/src/app
mkdir /usr/src/app
cd /tmp
curl -OL "https://github.com/zwave-js/zwave-js-server/archive/master.zip"
unzip master.zip
mv zwave-js-server-master/* /usr/src/app
rm master.zip
cd /usr/src/app

# Install app dependencies
npm install

SERIAL_PORT=$(cat /data/options.json | jq -r '.serial_port')

echo "using $SERIAL_PORT"

ts-node src/bin/server.ts ${SERIAL_PORT} --config /data/options.json
