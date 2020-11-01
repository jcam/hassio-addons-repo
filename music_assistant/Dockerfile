ARG MASS_VERSION=0.0.60

FROM marcelveldt/music-assistant:${MASS_VERSION}

ARG BASHIO_VERSION=0.9.0

# Setup bashio
RUN set -x \
    && mkdir -p /tmp/bashio \
    && curl -L -f -s "https://github.com/hassio-addons/bashio/archive/v${BASHIO_VERSION}.tar.gz" \
        | tar -xzf - --strip 1 -C /tmp/bashio \
    && mv /tmp/bashio/lib /usr/lib/bashio \
    && ln -s /usr/lib/bashio/bashio /usr/bin/bashio \
    && rm -rf /tmp/bashio

# copy rootfs
COPY rootfs /
# Labels
LABEL \
    io.hass.name="music_assistant" \
    io.hass.description="Multi-room, multi-platform streaming media organizer and streamer" \
    io.hass.type="addon" \
    io.hass.version=${MASS_VERSION} \
    maintainer="Marcel van der Veldt <m.vanderveldt@outlook.com>" \
    org.label-schema.description="Multi-room, multi-platform streaming media organizer and streamer" \
    org.label-schema.name="MusicAssistant" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://music-assistant.github.io" \
    org.label-schema.usage="https://github.com/music-assistant/server/tree/master/README.md" \
    org.label-schema.vcs-url="https://music-assistant.github.io" \
    org.label-schema.vendor="Marcelveldt's Add-ons for Home Assistant"