#!/bin/sh

# This script sets up WordPress and links it to the database (PHP 8.2 compatible)

WP_PATH="/var/www/html"
FPM_CONF="/etc/php82/php-fpm.d/www.conf"

# Create directories if needed
mkdir -p "${WP_PATH}"

# Set safe permissions and ownership (use www-data, common in PHP/WordPress images)
# If you need 'nginx', uncomment the creation lines below
# addgroup -g 82 -S nginx || true  # Create group if not exists (Alpine-style)
# adduser -u 82 -D -S -G nginx nginx || true  # Create user if not exists
chown -R www-data:www-data "${WP_PATH}" || chown -R $(whoami):$(whoami) "${WP_PATH}"  # Fallback to current user if www-data doesn't exist
chmod -R 755 "${WP_PATH}"

if [ ! -f "${WP_PATH}/wp-config.php" ]; then
    echo "Downloading WordPress..."
    php -d memory_limit=256M /bin/wp core download --allow-root --path="${WP_PATH}"
    
    # Check if download succeeded (verify a core file exists)
    if [ ! -f "${WP_PATH}/wp-settings.php" ]; then
        echo "Error: WordPress download/extraction failed. Check memory limits or WP-CLI version."
        exit 1 
    fi

    echo "Creating wp-config.php..."
    wp config create \
        --path="${WP_PATH}" \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWD}" \
        --dbhost="mysql" \
        --allow-root

    echo "Installing WordPress..."
    wp core install \
        --path="${WP_PATH}" \
        --url="https://localhost/wordpress" \
        --title="ft_services" \
        --admin_user="${MYSQL_USER}" \
        --admin_password="${MYSQL_PASSWD}" \
        --admin_email="${MYSQL_EMAIL}" \
        --allow-root
else
    echo "WordPress already installed."
fi

# Start PHP-FPM
echo "Starting PHP-FPM 8.2..."
php-fpm82 -F