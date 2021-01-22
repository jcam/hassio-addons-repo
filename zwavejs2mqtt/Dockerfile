ARG BUILD_VERSION
FROM zwavejs/zwavejs2mqtt:$BUILD_VERSION

RUN apk update && \
    apk add jq

ADD run.sh /
ENTRYPOINT [ "/run.sh" ]