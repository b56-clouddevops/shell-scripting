#!/bin/bash

# DATE="17JULY2023"

DATE=$(date +%F)
NO_OF_SESSIONS=$(who|wc -l)
echo -e "Good Morning , Todays date is \e[32m $DATE \e[0m" 
echo -e "Total Number Of Connected Sessions : \e[32m $NO_OF_SESSIONS \e[0m"
