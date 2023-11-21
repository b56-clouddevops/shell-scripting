#!/bin/bash 

echo -e "Demo On If , If Else & Else If Usage"

ACTION = $1 

if [ $ACTION = start ] ; then 
    echo "Starting Shipping Service"
    exit 0
fi 