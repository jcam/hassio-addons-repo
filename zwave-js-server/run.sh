#!/bin/bash

SERIAL_PORT=$(cat /data/options.json | jq -r '.serial_port')
SERVER_SOURCE=$(cat /data/options.json | jq -r '.server_branch_or_commit')
DRIVER_SOURCE=$(cat /data/options.json | jq -r '.driver_branch_or_commit')

cd /usr/src/app
echo "Fetching latest server version from $SERVER_SOURCE..."
npm install ${SERVER_SOURCE}
echo "Fetching latest driver version from $DRIVER_SOURCE..."
npm install ${DRIVER_SOURCE}

echo "Start Z-Wave Js Server using $SERIAL_PORT"
exec ./node_modules/.bin/zwave-server "$SERIAL_PORT"

