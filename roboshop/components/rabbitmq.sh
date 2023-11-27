#!/bin/bash

COMPONENT=rabbitmq

source components/common.sh 


echo -e "***** \e[35m Configuring ${COMPONENT} \e[0m ******"


echo -n "Configuring $COMPONENT repo :"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash    &>> $LOGFILE
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash   &>> $LOGFILE
stat $? 

echo -n "Installing $COMPONENT :"
yum install rabbitmq-server -y &>> $LOGFILE
stat $?

echo -n "Starting $COMPONENT Service :"
systemctl enable rabbitmq-server       &>> $LOGFILE
systemctl start rabbitmq-server        &>> $LOGFILE
stat $? 

echo -n "Creating $APPUSER for $COMPONENT: "
rabbitmqctl add_user roboshop roboshop123  &>> $LOGFILE
stat $? 

echo -n "Sorting Permissions :"
rabbitmqctl set_user_tags roboshop administrator
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

echo -e "***** \e[35m $COMPONENT Configuration Is Complted \e[0m ******"