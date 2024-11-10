FROM alpine:3.12

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

RUN apk update && apk upgrade \
	&& apk add nginx \
	&& apk add openssl ;mkdir /var/www/html\
	&& chown -R nginx:nginx /var/www/html && chmod -R 755 /var/www/html\
	&& mkdir -p /etc/nginx/ssl/ && mkdir -p /run/nginx \
	&& openssl req -x509 -nodes -out \
	"/etc/nginx/ssl/self.cert" -keyout "/etc/nginx/ssl/self.key" -subj "/"


EXPOSE 443 80

RUN sh -c 'echo -e "<h1>Hello World</h1>" > /var/www/html/index.html'

CMD ["nginx", "-g", "daemon off;"]
