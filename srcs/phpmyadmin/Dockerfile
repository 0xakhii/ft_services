FROM alpine:3.12

RUN apk update && apk upgrade \
	&& apk add lighttpd php fcgi php-cgi openrc php-mysqli

COPY ./conf/setup.sh /

RUN echo 'include "mod_fastcgi.conf"' >> /etc/lighttpd/lighttpd.conf \
	&& echo 'bin-path = "/usr/bin/php-cgi"' >> /etc/lighttpd/mod_fastcgi.conf \
	rc-service lighttpd start && rc-update add lighttpd default && chmod +x /setup.sh

EXPOSE 5000

CMD [ "sh", "/setup.sh" ]