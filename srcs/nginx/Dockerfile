FROM alpine:3.19
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./ssl/ /etc/nginx/ssl/
RUN apk update && apk upgrade \
    && apk add nginx \
    && mkdir -p /var/www/html /run/nginx \
    && chown -R nginx:nginx /var/www/html && chmod -R 755 /var/www/html
EXPOSE 80 443
RUN sh -c 'echo -e "<h1>Hello World</h1>" > /var/www/html/index.html'
HEALTHCHECK --interval=10s --timeout=3s CMD wget --spider -q http://localhost || exit 1
CMD ["nginx", "-g", "daemon off;"]