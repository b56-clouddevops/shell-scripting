#!/bin/bash 

echo -e "Demo On If , If Else & Else If Usage"

ACTION = $1 

if [ "$ACTION" == "start" ] ; then 
    echo -e "\e[32m Starting Shipping Service \e[0m"
    exit 0
fi 