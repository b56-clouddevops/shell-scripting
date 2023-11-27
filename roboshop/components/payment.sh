#!/bin/bash

COMPONENT=payment

echo -e "***** \e[35m Configuring ${COMPONENT} \e[0m ******"

source components/common.sh 
PYTHON                              # Calling PYTHON Function

echo -e "***** \e[35m $COMPONENT Configuration Is Complted \e[0m *****"