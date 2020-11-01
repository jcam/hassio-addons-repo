#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: MusicAssistant
# Configures MusicAssistant
# ==============================================================================


# Install latest version from PyPi
if bashio::config.true 'use_nightly'; then
    bashio::log.green "Updating to latest (prerelease) version..."
    pip install --upgrade --pre music-assistant
fi

if bashio::config.true 'debug_messages'; then
    bashio::log.green "Debug messages are enabled..."
    printf "true" > /var/run/s6/container_environment/DEBUG
else
    bashio::log.green "Debug messages are disabled..."
    printf "false" > /var/run/s6/container_environment/DEBUG
fi
