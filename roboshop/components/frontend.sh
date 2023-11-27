#!/bin/bash

USER_ID=$(id -u)
COMPONENT=frontend
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

echo -e "***** \e[35m Configuring ${COMPONENT} \e[0m ******"

echo -n "Installing Nginx :"
yum install nginx -y      &>> $LOGFILE
stat $?

echo -n "Downloading the ${COMPONENT} component:"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip" 
stat $?

echo -n "Clean up of ${COMPONENT} : "
cd /usr/share/nginx/html    
rm -rf *     &>>  ${LOGFILE}
stat $?

echo -n "Extracting ${COMPONENT} :"
unzip -o /tmp/${COMPONENT}.zip    &>> $LOGFILE
stat $?

echo -n  "Configuring $COMPONENT :"
mv ${COMPONENT}-main/* .
mv static/* .
rm -rf ${COMPONENT}-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo -n "Updating Revese Proxy :"
    for component in catalogue user cart shipping ; do 
        sed -i -e "/${component}/s/localhost/${component}.roboshop.internal/" /etc/nginx/default.d/roboshop.conf
    done 
stat $?

echo -n "Restarting $1 :"
systemctl enable nginx   &>> $LOGFILE
systemctl daemon-reload  &>> $LOGFILE
systemctl restart nginx  &>> $LOGFILE
stat $?

echo -e "***** \e[35m $COMPONENT Configuration Is Complted \e[0m ******"