FROM alpine:3.12

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

RUN apk update && apk upgrade \
	&& apk add nginx \
	&& mkdir /var/www/html && chmod 755 /var/www/html\
	&& mkdir -p /run/nginx

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
