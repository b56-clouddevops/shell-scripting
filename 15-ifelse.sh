#!/bin/bash 

echo -e "Demo On If , If Else & Else If Usage"

ACTION=$1 

if [ "$ACTION" == "start" ] ; then 
    echo -e "\e[32m Starting Shipping Service \e[0m"
    exit 0
elif [ "$ACTION" == "stop" ] ; then 
    echo -e "\e[31m Stopping Shipping Service \e[0m"
    exit 1
elif [ "$ACTION" == "restart" ] ; then 
    echo -e "\e[33m Restarting Shipping Service \e[0m"
    exit 2
else 
    echo -e "\e[35m Valid Options are start - stop - restart only \e[0m"
    exit 3  
fi 


