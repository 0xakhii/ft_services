#!/bin/bash

set -e

# This script sets up phpMyAdmin and links it to the database

PMA_VERSION="5.2.1"
PMA_URL="https://files.phpmyadmin.net/phpMyAdmin/${PMA_VERSION}/phpMyAdmin-${PMA_VERSION}-all-languages.tar.gz"


if ! command -v wget &> /dev/null; then
    echo "wget could not be found, installing it..."
    apk add --no-cache wget
fi

if ! command -v mariadb-install-db &> /dev/null; then
    echo "mariadb-install-db could not be found, installing MariaDB..."
    apk add --no-cache mariadb mariadb-client
fi

# Wait for the database to be ready
timeout=60
while ! mysqladmin ping -h "$DB_HOST" --silent; do
    timeout=$((timeout - 1))
    if [ $timeout -le 0 ]; then
        echo "Database did not start within the expected time."
        exit 1
    fi
    echo "Waiting for the database to be ready... ($timeout)"
    sleep 2
done

mysqladmin -h "$DB_HOST" -u "$PMA_USER" -p"$PMA_PASSWORD" password $PMA_PASSWORD

mkdir -p /usr/share/webapps/

cd /usr/share/webapps
wget $PMA_URL

tar zxvf phpMyAdmin-${PMA_VERSION}-all-languages.tar.gz
rm phpMyAdmin-${PMA_VERSION}-all-languages.tar.gz
mv phpMyAdmin-${PMA_VERSION}-all-languages phpmyadmin

chmod -R 755 /usr/share/webapps/

ln -s /usr/share/webapps/phpmyadmin/ /var/www/localhost/htdocs/phpmyadmin

rc-service lighttpd start && tail -f /dev/null