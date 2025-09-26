FROM alpine:3.19

WORKDIR /var/www/html/

RUN apk update && apk upgrade \
    && apk add --no-cache php82 php82-cli php82-mysqli php82-phar php82-mbstring php82-iconv php82-curl php82-fpm wget unzip \
    && ln -sf /usr/bin/php82 /usr/bin/php \
    && wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip \
    && unzip phpMyAdmin-latest-all-languages.zip \
    && mv phpMyAdmin-*-all-languages/* /var/www/html/ \
    && rm -rf phpMyAdmin-*-all-languages* \
    && chmod -R 755 /var/www/html

COPY ./conf/setup.sh /setup.sh

EXPOSE 5000

CMD ["/bin/sh", "/setup.sh"]
