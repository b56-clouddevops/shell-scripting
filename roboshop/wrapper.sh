#!/bin/bash 

bash components/$1.sh

if [ $? -ne 0 ]
    echo -e "\e31m example usage: \e[0m bash wrapper.sh componentName"
    exit 30
fi 
