FROM alpine:3.12

COPY setup.sh /

RUN apk update && apk upgrade \
	&& apk add mysql mysql-client openrc \
	&& mkdir -p /run/mysqld  && chmod +x /setup.sh

RUN sed -i 's/skip-networking/# skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf && \
	sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

CMD ["/bin/sh", "setup.sh" ]
