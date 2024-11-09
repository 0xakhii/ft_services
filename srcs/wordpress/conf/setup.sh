#!/bin/bash

# This script sets up wordpress and link it to the database
wp core download  --allow-root

wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWD --dbhost=mysql --allow-root

wp core install  --url=wordpress --title=ft_services --admin_user=$MYSQL_USER --admin_password=$MYSQL_PASSWD --admin_email=$MYSQL_EMAIL --allow-root

tail -f /dev/null