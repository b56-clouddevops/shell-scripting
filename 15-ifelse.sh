#!/bin/bash 

echo -e "Demo On If , If Else & Else If Usage"

ACTION=$1 

if [ "$ACTION" == "start" ] ; then 
    echo -e "\e[32m Starting Shipping Service \e[0m"
    exit 0
else 
    echo -e "\e[31m Valid Option is start only \e[0m"
    exit 1  
fi 

echo "It has not met any conditions"
exit 100

