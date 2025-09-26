FROM alpine:3.19

COPY ./nginx.conf /etc/nginx/nginx.conf

RUN apk update && apk upgrade \
    && apk add nginx \
    && mkdir -p /var/www/html /run/nginx \
    && chmod 755 /var/www/html \
    && chown -R nginx:nginx /var/www/html

EXPOSE 5050

CMD ["nginx", "-g", "daemon off;"]
