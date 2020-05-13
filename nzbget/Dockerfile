ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8
VOLUME ["/app"]

# Install app dependencies
RUN apk add --no-cache \
        wget \
        nginx

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Environment variables
ENV APP_NAME="NZBGet"
ENV APP_DIR="/data/app"
ENV APP_BIN_PATH="${APP_DIR}/nzbget"
ENV APP_CONF_PATH="/data/nzbget.conf"

# Labels
LABEL \
    io.hass.name="${APP_NAME}" \
    io.hass.description="The most efficient usenet downloader." \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Marcel van der Veldt @marcelveldt <m.vanderveldt@outlook.com>" \
    org.label-schema.description="The most efficient usenet downloader." \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="${APP_NAME}" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://github.com/marcelveldt/hassio-addons-repo/nzbget" \
    org.label-schema.usage="https://github.com/marcelveldt/hassio-addons-repo/tree/master/nzbget/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/marcelveldt/hassio-addons-repo/nzbget" \
    org.label-schema.vendor="Marcelveldt's Community Add-ons for Home Assistant"