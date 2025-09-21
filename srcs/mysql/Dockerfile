FROM alpine:3.19
COPY setup.sh /
RUN apk update && apk add --no-cache mariadb mariadb-client
RUN mkdir -p /run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql && \
    sed -i 's/skip-networking/# skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf && \
    sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf
EXPOSE 3306
HEALTHCHECK --interval=10s --timeout=3s CMD mysqladmin ping -h localhost || exit 1
CMD ["/bin/sh", "/setup.sh"]