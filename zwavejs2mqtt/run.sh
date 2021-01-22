#!/bin/bash

SERIAL_PORT=$(cat /data/options.json | jq -r '.serial_port')
NETWORK_KEY=$(cat /data/options.json | jq -r '.network_key')
USE_DEV=$(cat /data/options.json | jq -r '.use_dev_version')
DATA_DIR=$(cat /data/options.json | jq -r '.data_dir')
export NETWORK_KEY=$NETWORK_KEY
export STORE_DIR=$DATA_DIR
export SERIAL_PORT=$SERIAL_PORT

if [ "$USE_DEV" = "true" ]; then
    echo "Update to latest dev version of Zwave JS 2 MQTT..."
    npm install zwave-js/zwavejs2mqtt#master
fi

exec node bin/www
