#!/bin/bash

# This script sets up WordPress and links it to the database

# Check if WordPress is already set up
if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "Downloading WordPress..."
    wp core download --allow-root

    echo "Creating wp-config.php..."
    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWD}" \
        --dbhost="mysql" \
        --allow-root

    echo "Installing WordPress..."
    wp core install \
        --url="https://localhost/wordpress" \
        --title="ft_services" \
        --admin_user="${MYSQL_USER}" \
        --admin_password="${MYSQL_PASSWD}" \
        --admin_email="${MYSQL_EMAIL}" \
        --allow-root

    # Update PHP-FPM configuration
    sed -i "s/listen = 127.0.0.1:9000/listen = 9000/" /etc/php7/php-fpm.d/www.conf
fi

# Start PHP-FPM
echo "Starting PHP-FPM..."
php-fpm7 -F
