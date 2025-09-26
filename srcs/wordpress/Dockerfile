FROM alpine:3.19

WORKDIR /var/www/html/

RUN apk update && apk upgrade \
    && apk add --no-cache \
        php82 php82-cli php82-mysqli php82-phar php82-mbstring php82-iconv php82-curl php82-fpm wget bash \
    && ln -sf /usr/bin/php82 /usr/bin/php \
    && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /bin/wp

COPY ./conf/setup.sh /setup.sh

EXPOSE 5050

CMD ["/bin/sh", "/setup.sh"]
