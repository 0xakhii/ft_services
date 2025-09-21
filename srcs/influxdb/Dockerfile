FROM alpine:3.19
RUN apk update && apk add influxdb
EXPOSE 8086
VOLUME /var/lib/influxdb
CMD ["influxd"]