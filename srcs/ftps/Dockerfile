FROM alpine:3.12
RUN apk update && apk add vsftpd openssl
COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt -subj "/CN=localhost"
EXPOSE 21
CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]