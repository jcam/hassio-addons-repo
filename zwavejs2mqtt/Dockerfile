ARG BUILD_VERSION
# FROM zwavejs/zwavejs2mqtt:$BUILD_VERSION
# TEMP: use this dev version as it fixes the data path from env
FROM hikeit/zwavejs2mqtt:master-6.6.1-2sec

#RUN apk update && \
#    apk add --no-cache jq

VOLUME /data
ADD run.sh /
ADD default_settings.json /

CMD [ "/bin/sh", "/run.sh" ]
