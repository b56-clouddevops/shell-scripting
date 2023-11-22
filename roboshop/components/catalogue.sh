#!/bin/bash

USER_ID=$(id -u)
COMPONENT=catalogue
COMPONENT_URL="https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
LOGFILE="/tmp/${COMPONENT}.log"
APPUSER="roboshop"

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

# echo -n "Configuring Nodejs Repo :"
# curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
# stat $? 

echo -n "Installing Nodejs :"
yum install nodejs -y   &>> $LOGFILE
stat $? 

echo -e "Creating $APPUSER:"
id $APPUSER        &>> $LOGFILE
if [ $? -ne 0 ] ; then 
  useradd $APPUSER 
  stat $?
else 
  echo -e "\e[35m Skipping \e[0m"
fi 

echo -n "Downloading $COMPONENT :"
curl -s -L -o /tmp/$COMPONENT.zip $COMPONENT_URL
stat $? 

echo -n "Extracting $COMPONENT :"
cd /home/roboshop
unzip -o /tmp/${COMPONENT}.zip  &>> $LOGFILE
stat $?