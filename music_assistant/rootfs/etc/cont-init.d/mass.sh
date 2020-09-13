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
