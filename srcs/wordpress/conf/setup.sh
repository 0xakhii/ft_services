#!/bin/bash

# This script sets up WordPress and links it to the database

# Check if WordPress is already set up
if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "Downloading WordPress..."
    wp core download --path=/var/www/html --allow-root

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
    # Create nginx user and group if not exists
    if ! id -u nginx >/dev/null 2>&1; then
        addgroup -S nginx && adduser -S -G nginx nginx
    fi
    # Update PHP-FPM configuration
    sed -i "s/listen = 127.0.0.1:5050/listen = 0.0.0.0:5050/" /etc/php7/php-fpm.d/www.conf
    sed -i "s/;clear_env = no/clear_env = no/" /etc/php7/php-fpm.d/www.conf
    sed -i "s/group = nobody/group = nginx/" /etc/php7/php-fpm.d/www.conf
    sed -i "s/user = nobody/user = nginx/" /etc/php7/php-fpm.d/www.conf
    sed -i "s/;listen.owner = nobody/listen.owner = nginx/" /etc/php7/php-fpm.d/www.conf
    sed -i "s/;listen.group = nobody/listen.group = nginx/" /etc/php7/php-fpm.d/www.conf
    sed -i "/stop editing/i if (isset(\$_SERVER['HTTP_X_FORWARDED_PROTO']) && \$_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {\n    \$_SERVER['HTTPS'] = 'on';\n}" /var/www/html/wp-config.php
    # wp option update siteurl 'https://localhost/wordpress' --allow-root
    # wp option update home 'https://localhost/wordpress' --allow-root

fi

# Start PHP-FPM
echo "Starting PHP-FPM..."
php-fpm7 -F
