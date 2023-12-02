#!/bin/bash

COMPONENT=shipping

echo -e "***** \e[35m Configuring ${COMPONENT} \e[0m ******"

source components/common.sh 

MAVEN                                      # Calling JAVA Function

echo -e "***** \e[35m $COMPONENT Configuration Is Complted \e[0m ******"
set-hostname $COMPONENT