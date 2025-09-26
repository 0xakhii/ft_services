FROM alpine:3.19
COPY ./nginx.conf /etc/nginx/default.conf
# COPY ./ssl/ /etc/nginx/ssl/
RUN apk update && apk upgrade \
    && apk add nginx openssl \
    && mkdir -p /var/www/html /run/nginx /etc/nginx/ssl/ \
    && chown -R nginx:nginx /var/www/html && chmod -R 755 /var/www/html
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/self.key -out /etc/nginx/ssl/self.cert -subj "/CN=localhost"
EXPOSE 80 443
RUN sh -c 'echo -e "<h1>Hello World</h1>" > /var/www/html/index.html'
HEALTHCHECK --interval=10s --timeout=3s CMD wget --spider -q http://localhost || exit 1
CMD ["nginx", "-g", "daemon off;"]