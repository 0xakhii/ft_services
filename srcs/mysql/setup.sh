#!/bin/bash

# This script will create a database if not exists

# Start MariaDB in the background
mysqld_safe &

# Wait for MariaDB to start
while [ ! -S /run/mysqld/mysqld.sock ]; do
    sleep 1
done

# Execute MySQL commands
mysql -e "CREATE DATABASE IF NOT EXISTS \`${DATABASE_NAME}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${DATABASE_USER}\`@'localhost' IDENTIFIED BY '${DATABASE_PASSWD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${DATABASE_NAME}\`.* TO \`${DATABASE_USER}\`@'%' IDENTIFIED BY '${DATABASE_PASSWD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DATABASE_ROOT_PASSWD}';"
mysql -u root -p${DATABASE_ROOT_PASSWD} -e "FLUSH PRIVILEGES;"

# Keep the container running
tail -f /dev/null