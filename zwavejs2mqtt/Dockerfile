ARG BUILD_VERSION
FROM zwavejs/zwavejs2mqtt:$BUILD_VERSION

RUN apk update && \
    apk add --no-cache jq nginx

VOLUME /data
ADD run.sh /
ADD default_settings.json /
ADD nginx.conf /etc/nginx/nginx.conf

CMD [ "/bin/sh", "/run.sh" ]