#!/bin/bash

COMPONENT=cart
LOGFILE="/tmp/${COMPONENT}.log"

echo -n "Configuring Nodejs Repo :"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
stat $? 

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

echo -n "Performing Cleanup of $COMPONENT:"
rm -rf $APPUSER_HOME &>> $LOGFILE
stat $?

echo -n "Extracting $COMPONENT :"
cd /home/roboshop
unzip -o /tmp/$COMPONENT.zip  &>> $LOGFILE
stat $?

echo -n "Configuring $COMPONENT permissions :"
mv ${APPUSER_HOME}-main $APPUSER_HOME
chown -R $APPUSER:$APPUSER  $APPUSER_HOME
chmod -R 770  $APPUSER_HOME
stat $?

echo -n "Generating Artifacts : "
cd $APPUSER_HOME 
npm install &>> $LOGFILE 
stat $? 

echo -n "Configuring the $COMPONENT systemd file :"
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' ${APPUSER_HOME}/systemd.service
mv ${APPUSER_HOME}/systemd.service /etc/systemd/system/${COMPONENT}.service
stat $?

echo -n "Starting $COMPONENT service :"
systemctl daemon-reload &>> $LOGFILE
systemctl enable $COMPONENT &>> $LOGFILE
systemctl restart $COMPONENT &>> $LOGFILE
stat $? 

echo -e "***** \e[35m $COMPONENT Configuration Is Complted \e[0m ******"