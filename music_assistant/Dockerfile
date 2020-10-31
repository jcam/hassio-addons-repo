FROM python:slim

# Build arguments
ARG BUILD_ARCH=amd64
ARG BUILD_VERSION=0.0.60
ARG BUILD_DATE
ARG BUILD_REF
ARG MASS_VERSION="${BUILD_VERSION}"
ARG JEMALLOC_VERSION=5.2.1
ARG S6_OVERLAY_VERSION=2.1.0.2
ARG BASHIO_VERSION=0.9.0

RUN apt-get update && apt-get install -y --no-install-recommends \
		# required packages
		wget bash jq flac sox libsox-fmt-mp3 zip curl unzip ffmpeg libsndfile1 libtag1v5 \
		# build packages
		libtag1-dev build-essential git libblas3 liblapack3 liblapack-dev libblas-dev gfortran libatlas-base-dev && \
    # make sure uvloop and aiohttp is installed with recommended packages
    pip install --upgrade uvloop aiohttp[speedups] && \
    # Setup jemalloc
    curl -L -s https://github.com/jemalloc/jemalloc/releases/download/${JEMALLOC_VERSION}/jemalloc-${JEMALLOC_VERSION}.tar.bz2 | tar -xjf - -C /usr/src && \
    cd /usr/src/jemalloc-${JEMALLOC_VERSION} && \
    ./configure && \
    make && \
    make install && \
    rm -rf /usr/src/jemalloc-${JEMALLOC_VERSION} && \
    # Setup s6 overlay
    curl -L -s "https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-${BUILD_ARCH}.tar.gz" | tar zxvf - -C / && \
    mkdir -p /etc/fix-attrs.d && \
    mkdir -p /etc/services.d && \
    # Setup bashio
    mkdir -p /tmp/bashio && \
    curl -L -s https://github.com/hassio-addons/bashio/archive/v${BASHIO_VERSION}.tar.gz | tar -xzf - --strip 1 -C /tmp/bashio && \
    mv /tmp/bashio/lib /usr/lib/bashio && \
    ln -s /usr/lib/bashio/bashio /usr/bin/bashio && \
    rm -rf /tmp/bashio && \
    # install music assistant
    cd /tmp && pip install --upgrade music-assistant==${MASS_VERSION} && \
	# cleanup build packages
	apt-get purge -y --auto-remove libtag1-dev build-essential libblas3 liblapack3 liblapack-dev libblas-dev gfortran libatlas-base-dev && \
	rm -rf /var/lib/apt/lists/*

# copy rootfs
COPY rootfs /

ENTRYPOINT ["/init"]

# Labels
LABEL \
    io.hass.name="music_assistant" \
    io.hass.description="Multi-room, multi-platform streaming media organizer and streamer" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Marcel van der Veldt <m.vanderveldt@outlook.com>" \
    org.label-schema.description="Multi-room, multi-platform streaming media organizer and streamer" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="MusicAssistant" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://music-assistant.github.io" \
    org.label-schema.usage="https://github.com/music-assistant/server/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://music-assistant.github.io" \
    org.label-schema.vendor="Marcelveldt's Add-ons for Home Assistant"