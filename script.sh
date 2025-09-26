#!/bin/bash

# Start a k8s cluster
minikube start --driver=kvm2

# Wait for minikube to be ready
kubectl wait --for=condition=Ready nodes --all --timeout=300s

# Create or update ConfigMap from .env file
kubectl delete configmap global-env --ignore-not-found
kubectl create configmap global-env --from-env-file=srcs/.env

# Configure docker to use minikube's docker daemon
eval $(minikube docker-env)

# Build docker images directly inside minikube's docker
docker build -t my-mysql:latest ./srcs/mysql
docker build -t my-nginx:latest ./srcs/nginx
docker build -t my-wordpress:latest ./srcs/wordpress
docker build -t my-nginx-wordpress:latest ./srcs/wordpress/nginx
docker build -t my-phpmyadmin:latest ./srcs/phpmyadmin
docker build -t my-nginx-phpmyadmin:latest ./srcs/phpmyadmin/nginx
docker build -t my-ftps:latest ./srcs/ftps
docker build -t my-influxdb:latest ./srcs/influxdb
docker build -t my-grafana:latest ./srcs/grafana
# Create Persistent Volume Claims
kubectl apply -f ./srcs/mysql/mysql_pvc.yaml
kubectl apply -f ./srcs/influxdb/influxdb_pvc.yaml
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin_pvc.yaml
kubectl apply -f ./srcs/wordpress/wordpress_pvc.yaml
# Deploy resources
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/main/config/manifests/metallb-native.yaml
kubectl apply -f ./srcs/metallb/metallb-config.yaml
kubectl apply -f ./srcs/mysql/deployment.yaml
kubectl wait --for=condition=ready pod -l app=mysql --timeout=300s
kubectl apply -f ./srcs/nginx/deployment.yaml
kubectl apply -f ./srcs/wordpress/deployment.yaml
kubectl apply -f ./srcs/phpmyadmin/deployment.yaml
kubectl apply -f ./srcs/ftps/kubernetes.yaml
kubectl apply -f ./srcs/influxdb/kubernetes.yaml
kubectl apply -f ./srcs/grafana/kubernetes.yaml

kubectl create secret generic -n metallb-system memberlist  --from-literal=secretkey="$(openssl rand -base64 128)"

