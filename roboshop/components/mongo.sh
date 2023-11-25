#!/bin/bash


COMPONENT=mongodb
MONGO_REPO="https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo"
SCHEMA_URL="https://github.com/stans-robot-project/mongodb/archive/main.zip"

source components/common.sh 

echo -e "***** \e[35m Configuring ${COMPONENT} \e[0m ******"

echo -n "Configuring $COMPONENT repo :"
curl -s -o /etc/yum.repos.d/mongodb.repo $MONGO_REPO
stat $? 

echo -n "Installing $COMPONENT :"
yum install -y mongodb-org  &>> ${LOGFILE}
stat $?

echo -n "Enabling $COMPONENT visibility :"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $? 

echo -n "Starting $COMPONENT :"
systemctl enable mongo   &>> $LOGFILE
systemctl daemon-reload  &>> $LOGFILE
systemctl restart mongod  &>> $LOGFILE
stat $?

echo -n "Downloading $COMPONENT Schema :"
curl -s -L -o /tmp/mongodb.zip $SCHEMA_URL 
stat $? 

echo -n "Extracting $COMPONENT :"
cd /tmp 
unzip -o mongodb.zip    &>> $LOGFILE
stat $? 

echo -n "Injecting Schem :"
cd /tmp/mongodb-main
mongo < catalogue.js  &>> $LOGFILE
mongo < users.js      &>> $LOGFILE
stat $? 

echo -e "***** \e[35m $COMPONENT Configuration Is Complted \e[0m ******"