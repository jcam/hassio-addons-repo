#!/usr/bin/bash
# ==============================================================================
# Home Assistant Community Add-on: MusicAssistant
# Configures MusicAssistant
# ==============================================================================


# Install latest version from git
if bashio::config.true 'use_nightly'; then
    bashio::log.green "Updating to latest nightly version..."
    cd /tmp
    curl -L https://github.com/music-assistant/server/archive/master.tar.gz | tar xz
    cd server-master
    python3 setup.py install
    rm -rf /tmp/*
fi

if bashio::config.true 'debug_messages'; then
    bashio::log.green "Debug messages are enabled..."
    mass --config /data --debug
else
    bashio::log.green "Debug messages are disabled..."
    mass --config /data
fi
