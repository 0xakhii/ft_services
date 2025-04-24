#!/bin/bash
# start a minikube cluster
minikube start --driver=virtualbox


#Build docker images
docker build -t my-mysql:latest ./srcs/mysql
docker build -t my-nginx:latest ./srcs/nginx
docker build -t my-wordpress:latest ./srcs/wordpress
docker build -t my-wordpress-nginx:latest ./srcs/wordpress/nginx
docker build -t my-phpmyadmin:latest ./srcs/phpmyadmin
docker build -t my-phpmyadmin-nginx:latest ./srcs/phpmyadmin/nginx
docker build -t my-ftps:latest ./srcs/ftps
docker build -t my-influxdb:latest ./srcs/influxdb
docker build -t my-grafana:latest ./srcs/grafana


#Save docker images as .tar format
docker save -o my-mysql.tar my-mysql:latest
docker save -o my-nginx.tar my-nginx:latest
docker save -o my-wordpress.tar my-wordpress:latest
docker save -o my-wordpress-nginx.tar my-wordpress-nginx:latest
docker save -o my-phpmyadmin.tar my-phpmyadmin:latest
docker save -o my-phpmyadmin-nginx.tar my-phpmyadmin-nginx:latest
docker save -o my-ftps.tar my-ftps:latest
docker save -o my-influxdb.tar my-influxdb:latest
docker save -o my-grafana.tar my-grafana:latest


#Load docker images to minikube
minikube image load my-mysql.tar
minikube image load my-nginx.tar
minikube image load my-wordpress.tar
minikube image load my-wordpress-nginx.tar
minikube image load my-phpmyadmin.tar
minikube image load my-phpmyadmin-nginx.tar
minikube image load my-ftps.tar
minikube image load my-influxdb.tar
minikube image load my-grafana.tar


#Deploy
kubectl apply -f ./srcs/metallb/metallb-config.yaml
kubectl apply -f ./srcs/mysql/deployment.yaml
kubectl apply -f ./srcs/nginx/deployment.yaml
kubectl apply -f ./srcs/wordpress/deployment.yaml
kubectl apply -f ./srcs/phpmyadmin/deployment.yaml
kubectl apply -f ./srcs/ftps/kubernetes.yaml
kubectl apply -f ./srcs/influxdb/kubernetes.yaml
kubectl apply -f ./srcs/grafana/kubernetes.yaml