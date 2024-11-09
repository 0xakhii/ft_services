#!/bin/bash

# This script will run the application 

# check the arguments passed to the script

if [ $1 == "up" ] || [ $1 == "down" ] || [ $1 == "re" ] || [ $1 == "clean" ]
then
	if [ $1 == "up" ]
	then
		mkdir -p ~/data/wordpress
		docker-compose -f srcs/docker-compose.yml up
	elif [ $1 == "down" ]
	then
		rm -rf ~/data/wordpress
		docker-compose -f srcs/docker-compose.yml down
	elif [ $1 == "re" ]
	then
		docker-compose -f srcs/docker-compose.yml down
		docker-compose -f srcs/docker-compose.yml up
	elif [ $1 == "clean" ]
	then
		sudo rm -rf ~/data/wordpress
		docker volume rm $(docker volume ls -q)
		docker stop $(docker ps -a -q)
		docker rm $(docker ps -a -q)
		docker rmi $(docker images -aq)
	fi
else
	echo "Invalid argument passed. Please pass either up, down or re"
fi