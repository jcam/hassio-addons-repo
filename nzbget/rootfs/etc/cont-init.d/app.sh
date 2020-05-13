#!/usr/bin/with-contenv bashio
# ==============================================================================
# Pre-configuration and installation of the app
# App is installed in /app folder to make sure the auto-update function works
# ==============================================================================

# Download and install into /app volume if needed
if ! bashio::fs.file_exists "${APP_BIN_PATH}"; then
    bashio::log.green "Download and install ${APP_NAME}..."
    wget -q https://nzbget.net/download/nzbget-latest-bin-linux.run
    sh nzbget-latest-bin-linux.run --silent --destdir "${APP_DIR}"
    rm nzbget-latest-bin-linux.run
fi

# default config
if ! bashio::fs.file_exists "${APP_CONF_PATH}"; then
    cp "$APP_DIR/nzbget.conf" $APP_CONF_PATH
    sed -i "/^MainDir=/s/=.*/=\/share\/downloads/" $APP_CONF_PATH
fi