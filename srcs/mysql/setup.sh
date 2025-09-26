#!/bin/bash
set -e

# This script sets up the database

chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /run/mysqld

wait_for_mariadb() {
    echo "Waiting for MariaDB to start..."
    until mysqladmin ping --silent >/dev/null 2>&1; do
        sleep 0.5
    done
}

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    cat > /tmp/mysql-init.sql <<-SQL
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWD}';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWD}';
CREATE USER IF NOT EXISTS '${PMA_USER}'@'%' IDENTIFIED BY '${PMA_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${PMA_USER}'@'%';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
SQL
    mysqld_safe --skip-syslog --datadir=/var/lib/mysql --init-file=/tmp/mysql-init.sql &
else
    echo "Existing database detected, starting MariaDB..."
    mysqld_safe --skip-syslog --datadir=/var/lib/mysql &
fi

wait_for_mariadb
rm -f /tmp/mysql-init.sql || true

# verify root can connect with the password
mysql -u root -p"${MYSQL_ROOT_PASSWD}" -e "SELECT 1" >/dev/null 2>&1 || { echo "Cannot connect as root with provided password"; exit 1; }

# ensure database and users exist (idempotent)
mysql -u root -p"${MYSQL_ROOT_PASSWD}" -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -u root -p"${MYSQL_ROOT_PASSWD}" -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWD}';"
mysql -u root -p"${MYSQL_ROOT_PASSWD}" -e "CREATE USER IF NOT EXISTS '${PMA_USER}'@'%' IDENTIFIED BY '${PMA_PASSWORD}';"
mysql -u root -p"${MYSQL_ROOT_PASSWD}" -e "GRANT ALL PRIVILEGES ON *.* TO '${PMA_USER}'@'%';"
mysql -u root -p"${MYSQL_ROOT_PASSWD}" -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
mysql -u root -p"${MYSQL_ROOT_PASSWD}" -e "FLUSH PRIVILEGES;"

echo "Database setup completed successfully."

tail -f /dev/null