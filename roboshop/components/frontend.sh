#!/bin/bash

USER_ID=$(id -u)
COMPONENT=$1 
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

echo -e "***** \e[35m Configuring $COMPONENT \e[0m ******"

echo -n "Installing Nginx :"
yum install nginx -y      &>> $LOGFILE
stat $?

echo -n "Downloading Component $COMPONENT :"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
stat $?

echo -n "Cleanup of $1 component : "
cd /usr/share/nginx/html 
rm -rf *     &>> $LOGFILE
stat $?

echo -n "Extracting $1: "
unzip /tmp/frontend.zip     &>> $LOGFILE
stat $?

echo -n  "Configuring $COMPONENT :"
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo -n "Restarting $1 :"
systemctl enable nginx   &>> $LOGFILE
systemctl daemon-reload  &>> $LOGFILE
systemctl restart nginx  &>> $LOGFILE
stat $?

echo -e "***** \e[35m $COMPONENT Configuration Is Complted \e[0m ******"