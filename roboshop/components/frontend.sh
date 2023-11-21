#!/bin/bash

echo -e "***** \e[35m Configuring frontend \e[0m ******"

echo "Installing Nginx :"
yum install nginx -y

# systemctl enable nginx
# systemctl start nginx
# curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/frontend.zip
# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf
