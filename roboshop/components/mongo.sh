#!/bin/bash

USER_ID=$(id -u)
COMPONENT=mongo
LOGFILE="/tmp/${COMPONENT}.log"
MONGO_REPO="https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo"

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

echo -e "***** \e[35m Configuring ${COMPONENT} \e[0m ******"

echo -n "Configuring $COMPONENT repo :"
curl -s -o /etc/yum.repos.d/mongodb.repo $MONGO_REPO
stat $? 

echo -n "Installing $COMPONENT :"
yum install -y mongodb-org  &>> ${LOGFILE}
stat $?

