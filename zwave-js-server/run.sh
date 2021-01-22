#!/bin/bash

SERIAL_PORT=$(cat /data/options.json | jq -r '.serial_port')
SERVER_SOURCE=$(cat /data/options.json | jq -r '.branch_or_commit')
NETWORK_KEY=$(cat /data/options.json | jq -r '.networkKey')
USE_ZWJS2MQTT=$(cat /data/options.json | jq -r '.use_zwjs2mqtt_control_panel')
CACHEDIR=$(cat /data/options.json | jq -r '.storage.cacheDir')

cd /usr/src/app
echo "Fetching latest server version from $SERVER_SOURCE..."
npm install ${SERVER_SOURCE}

if [ "$USE_ZWJS2MQTT" = "true" ]; then
    echo "Start Zwave JS 2 MQTT..."
    export NETWORK_KEY=$NETWORK_KEY
    export STORE_DIR=$CACHEDIR
    npm install zwave-js/zwavejs2mqtt#master
    npm run build
    exec ./node_modules/.bin/zwavejs2mqtt
else
    echo "Start Z-Wave Js Server using $SERIAL_PORT"
    exec ./node_modules/.bin/zwave-server "$SERIAL_PORT" --config /data/options.json    
fi


