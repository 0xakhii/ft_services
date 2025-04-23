#!/bin/bash

docker build -t nginx-reverse:latest -f ./srcs/nginx/Dockerfile --build-arg COPY_PATH=srcs/nginx .
docker build -t mysql:latest -f ./srcs/mysql/Dockerfile --build-arg COPY_PATH=srcs/mysql .
docker build -t phpmyadmin-nginx:latest -f ./srcs/phpmyadmin/nginx/Dockerfile --build-arg COPY_PATH=srcs/phpmyadmin/nginx .
docker build -t phpmyadmin:latest -f ./srcs/phpmyadmin/Dockerfile --build-arg COPY_PATH=srcs/phpmyadmin/ .
docker build -t wordpress-nginx:latest -f ./srcs/wordpress/nginx/Dockerfile --build-arg COPY_PATH=srcs/wordpress/nginx .
docker build -t wordpress:latest -f ./srcs/wordpress/Dockerfile --build-arg COPY_PATH=srcs/wordpress/ .
