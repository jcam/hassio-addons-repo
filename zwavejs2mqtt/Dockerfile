ARG BUILD_VERSION
FROM zwavejs/zwavejs2mqtt:$BUILD_VERSION

ADD nginx.conf /etc/nginx/nginx.conf
RUN apk update && \
    apk add --no-cache jq nginx

VOLUME /data
ADD run.sh /
ADD default_settings.json /data

CMD [ "/bin/sh", "/run.sh" ]