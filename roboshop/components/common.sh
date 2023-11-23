#!/bin/bash

COMPONENT_URL="https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
LOGFILE="/tmp/${COMPONENT}.log"
APPUSER="roboshop"
APPUSER_HOME="/home/${APPUSER}/${COMPONENT}"
USER_ID=$(id -u)

if [ $USER_ID -ne 0 ] ; then 
    echo -e "\e[31m This script is expected to be executed with sudo or as a root user \e[0m"
    echo -e "\e[35m Example Usage: \n\t\t \e[0m sudo bash scriptName componentName"
    exit 1 
fi 

stat() {
    if [ $1 -eq 0 ] ; then 
        echo -e "\e[32m Success \e[0m"
    else 
        echo -e "\e[31m Failure \e[0m"
    fi 
}