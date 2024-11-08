#!/bin/bash

# This script sets up the database

chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

mysqld_safe --skip-syslog --datadir=/var/lib/mysql &

echo "Waiting for MariaDB to start..."
until mysqladmin ping --silent; do
    sleep 1
done

mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -u root -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';"
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWD}';"
mysql -u root -p${MYSQL_ROOT_PASSWD} -e "FLUSH PRIVILEGES;"

echo "Database setup completed successfully."

tail -f /dev/null
