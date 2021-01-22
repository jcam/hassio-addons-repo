ARG BUILD_VERSION
FROM zwavejs/zwavejs2mqtt:$BUILD_VERSION

RUN apk update && \
    apk add --no-cache jq

ADD run.sh /
CMD [ "/bin/sh", "/run.sh" ]