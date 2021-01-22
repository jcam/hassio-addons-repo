#!/bin/sh

SERIAL_PORT=$(cat /data/options.json | jq -r '.serial_port')
NETWORK_KEY=$(cat /data/options.json | jq -r '.network_key')
USE_DEV=$(cat /data/options.json | jq -r '.use_dev_version')
DATA_DIR=$(cat /data/options.json | jq -r '.data_dir')
export NETWORK_KEY=$NETWORK_KEY
export STORE_DIR=$DATA_DIR
export SERIAL_PORT=$SERIAL_PORT

echo "NETWORK_KEY=$NETWORK_KEY"
echo "STORE_DIR=$DATA_DIR"
echo "SERIAL_PORT=$SERIAL_PORT"

# update to latest version from master if enabled
if [ "$USE_DEV" = "true" ]; then
    echo "Update to latest dev version of Zwave JS 2 MQTT..."
    npm install zwave-js/zwavejs2mqtt#master
fi

# default config
FILE=/data/settings.json
if [ ! -f "/data/settings.json" ]; then
    mv /data/default_settings.json /data/settings.json
fi
# update config
jq -c '.zwave.port = "$SERIAL_PORT"' /data/settings.json > tmp.$$.json && mv tmp.$$.json /data/settings.json
jq -c '.zwave.networkKey = "$NETWORK_KEY"' /data/settings.json > tmp.$$.json && mv tmp.$$.json /data/settings.json

nginx -g 'pid /tmp/nginx.pid;'
nginx && node bin/www
