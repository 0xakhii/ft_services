FROM alpine:3.12

ARG COPY_PATH
WORKDIR /var/www/html/

RUN apk update && apk upgrade \
    && apk add --no-cache php7 php7-cli php7-mysqli php7-phar php7-json php7-mbstring php7-iconv php7-curl php7-fpm wget \
    && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /bin/wp

COPY ${COPY_PATH}/conf/setup.sh /setup.sh

EXPOSE 5050

CMD ["/bin/sh", "/setup.sh"]
