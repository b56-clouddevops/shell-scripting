#!/bin/bash

COMPONENT_URL="https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
APPUSER="roboshop"
APPUSER_HOME="/home/${APPUSER}/${COMPONENT}"
USER_ID=$(id -u)
LOGFILE="/tmp/${COMPONENT}.log"

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

CREATE_USER() {

    echo -e "Creating $APPUSER:"
    id $APPUSER        &>> $LOGFILE
    if [ $? -ne 0 ] ; then 
    useradd $APPUSER 
    stat $?
    else 
    echo -e "\e[35m Skipping \e[0m"
    fi

}

DOWNLOAD_AND_EXTRACT() {

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

}

CONFIG_SVC() {

    echo -n "Configuring $COMPONENT permissions :"
    mv ${APPUSER_HOME}-main $APPUSER_HOME
    chown -R $APPUSER:$APPUSER  $APPUSER_HOME
    chmod -R 770  $APPUSER_HOME
    stat $?

    echo -n "Configuring the $COMPONENT systemd file :"
    sed -i -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' ${APPUSER_HOME}/systemd.service
    mv ${APPUSER_HOME}/systemd.service /etc/systemd/system/${COMPONENT}.service
    stat $?
}

START_SVC() {

    echo -n "Starting $COMPONENT service :"
    systemctl daemon-reload &>> $LOGFILE
    systemctl enable $COMPONENT &>> $LOGFILE
    systemctl restart $COMPONENT &>> $LOGFILE
    stat $?

}

NODEJS() {

    echo -n "Configuring Nodejs Repo :"
    curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
    stat $? 

    echo -n "Installing Nodejs :"
    yum install nodejs -y   &>> $LOGFILE
    stat $? 

    CREATE_USER                 # calls create user function that creates user

    DOWNLOAD_AND_EXTRACT 

    CONFIG_SVC

    echo -n "Generating Artifacts : "
    cd $APPUSER_HOME 
    npm install &>> $LOGFILE 
    stat $? 
    
    START_SVC

}
