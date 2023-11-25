#!/bin/bash

COMPONENT=mysql
COMPONENT_URL="https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo"
source components/common.sh


echo -e "***** \e[35m Configuring ${COMPONENT} \e[0m ******"


echo -n "Configuring $COMPONENT repo:" 
curl -s -L -o /etc/yum.repos.d/mysql.repo $COMPONENT_URL &>> $LOGFILE
stat $? 

echo -n "Installing $COMPONENT :"
yum install mysql-community-server -y &>> $LOGFILE
state $?

echo -n "Starting $1 :"
systemctl enable mysqld   &>> $LOGFILE
systemctl start mysqld  &>> $LOGFILE
stat $?