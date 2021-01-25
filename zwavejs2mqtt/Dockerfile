ARG BUILD_VERSION
# FROM zwavejs/zwavejs2mqtt:$BUILD_VERSION
# TEMP: use this dev version as it fixes the data path from env
FROM hikeit/zwavejs2mqtt:2sec-1.5

#RUN apk update && \
#    apk add --no-cache jq

VOLUME /data
ADD run.sh /
ADD default_settings.json /

CMD [ "/bin/sh", "/run.sh" ]
