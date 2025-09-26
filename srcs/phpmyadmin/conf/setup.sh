#!/bin/bash

set -e

# This script sets up phpMyAdmin and links it to the database

# Wait for the database to be ready
timeout=60
while ! mysqladmin ping -h "$DB_HOST" --silent; do
    timeout=$((timeout - 1))
    if [ $timeout -le 0 ]; then
        echo "Database did not start within the expected time."
        exit 1
    fi
    echo "Waiting for the database '$DB_HOST' to be ready... ($timeout)"
    sleep 2
done


chmod -R 755 /usr/share/webapps/

mkdir -p /var/www/localhost/htdocs/phpmyadmin

ln -s /usr/share/webapps/phpmyadmin/ /var/www/localhost/htdocs/phpmyadmin

# Run lighttpd in foreground
exec lighttpd -D -f /etc/lighttpd/lighttpd.conf