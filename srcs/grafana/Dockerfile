FROM alpine:3.19
RUN apk update && apk upgrade

RUN wget -q -O- https://packages.grafana.com/gpg.key; \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories ; \
    echo "https://dl.grafana.com/oss/deb stable InRelease" > /etc/apk/keys/grafana.gpg ; \
    echo "https://dl.grafana.com/oss/deb stable main" > /etc/apk/grafana.conf
RUN apk update && apk add grafana
EXPOSE 3000
CMD ["grafana-server", "--homepath=/usr/share/grafana"]