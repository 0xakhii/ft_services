FROM alpine:3.19
RUN apk update && apk upgrade \
    && apk add php7 php7-fpm php7-mysqli php7-mbstring php7-session php7-json wget
COPY ./conf/setup.sh /
RUN chmod +x /setup.sh && \
    wget -O /tmp/phpmyadmin.tar.gz https://files.phpmyadmin.net/phpMyAdmin/5.2.1/phpMyAdmin-5.2.1-all-languages.tar.gz && \
    tar -xzf /tmp/phpmyadmin.tar.gz -C /tmp && \
    mv /tmp/phpMyAdmin-5.2.1-all-languages /var/www/phpmyadmin && \
    chown -R nobody:nobody /var/www/phpmyadmin
EXPOSE 9000 
HEALTHCHECK --interval=10s --timeout=3s CMD wget --spider -q http://localhost:9000 || exit 1
CMD ["/bin/sh", "/setup.sh"]