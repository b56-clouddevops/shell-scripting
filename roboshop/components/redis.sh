#!/bin/bash

USER_ID=$(id -u)
COMPONENT=redis
LOGFILE="/tmp/${COMPONENT}.log"

stat() {
    if [ $1 -eq 0 ] ; then 
        echo -e "\e[32m Success \e[0m"
    else 
        echo -e "\e[31m Failure \e[0m"
    fi 
}

if [ $USER_ID -ne 0 ] ; then 
    echo -e "\e[31m This script is expected to be executed with sudo or as a root user \e[0m"
    echo -e "\e[35m Example Usage: \n\t\t \e[0m sudo bash scriptName componentName"
    exit 1 
fi 

echo -n "Configuring $COMPONENT repo :"
curl -L https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/${COMPONENT}.repo -o /etc/yum.repos.d/${COMPONENT}.repo
stat $? 

echo -n "Installing $COMPONENT :"
yum install redis-6.2.13 -y &>> $LOGFILE
stat $? 



