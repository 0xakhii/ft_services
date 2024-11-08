#!/bin/bash

# This script will run the application 

# check the arguments passed to the script

if [ $1 == "up" ] || [ $1 == "down" ] || [ $1 == "re" ]
then
	if [ $1 == "up" ]
	then
		docker-compose -f srcs/docker-compose.yml up
	elif [ $1 == "down" ]
	then
		docker-compose -f srcs/docker-compose.yml down
	elif [ $1 == "re" ]
	then
		docker-compose -f srcs/docker-compose.yml down
		docker-compose -f srcs/docker-compose.yml up
	fi
else
	echo "Invalid argument passed. Please pass either up, down or re"
fi