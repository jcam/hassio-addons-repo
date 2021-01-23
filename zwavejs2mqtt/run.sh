#!/bin/sh

SERIAL_PORT=$(cat /data/options.json | jq -r '.serial_port')
NETWORK_KEY=$(cat /data/options.json | jq -r '.network_key')

# default config
FILE=/data/settings.json
if [ ! -f "/data/settings.json" ]; then
    mv /default_settings.json /data/settings.json
fi
# update config
jq --arg a "${SERIAL_PORT}" '.zwave.port = $a' /data/settings.json > tmp.$$.json && mv tmp.$$.json /data/settings.json
jq --arg a "${NETWORK_KEY}" '.zwave.networkKey = $a' /data/settings.json > tmp.$$.json && mv tmp.$$.json /data/settings.json

# start running
export STORE_DIR="/data"
exec node bin/www