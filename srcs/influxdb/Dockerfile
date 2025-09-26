FROM alpine:3.19

RUN apk update && apk add --no-cache wget tar

# Download InfluxDB
RUN wget https://download.influxdata.com/influxdb/releases/v2.7.12/influxdb2-2.7.12_linux_amd64.tar.gz && \
    tar xvzf influxdb2-2.7.12_linux_amd64.tar.gz && \
    mv influxdb2-2.7.12/usr/bin/influxd /usr/local/bin/ && \
    rm -rf influxdb2-2.7.12_linux_amd64*

EXPOSE 8086
VOLUME /var/lib/influxdb
CMD ["influxd"]