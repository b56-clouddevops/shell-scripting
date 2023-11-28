#!/bin/bash 

# This script is going to create EC2 Servers

# AMI_ID="ami-0f75a13ad2e340a58" # Hardcoding is a bad-choice particularly with AMI_ID as it's going be changed when you register a new AMI.
# SGID="sg-052fd946b7e11841a"

if [ -z $1 ] ; then 
    echo -e "\e[31m ****** COMPONENT NAME IS NEEDED ****** \e[0m \n\t\t"
    echo -e "\e[36m \t\t Example Usage : \e[0m  bash create-ec2 ratings"
    exit 1 
fi 

COMPONENT=$1
HOSTEDZONEID="Z031297333JO38PNHPROR"
AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq ".Images[].ImageId" | sed -e 's/"//g')
SGID=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=b56-allow-all" | jq ".SecurityGroups[].GroupId" | sed -e 's/"//g')
INSTANCE_TYPE="t3.micro"

create_server() {
    echo -e "******* \e[32m $COMPONENT \e[0m Server Creation In Progress ******* !!!!!!"
    PRIVATE_IP=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE} --security-group-ids ${SGID} --tag-specifications "ResourceType=instance, Tags=[{Key=Name,Value=${COMPONENT}}]" | jq ".Instances[].PrivateIpAddress" | sed -e 's/"//g')
    echo -e "******* \e[32m $COMPONENT \e[0m Server Creation Is Complted ******* !!!!!! \n\n"

    echo -e "******* \e[32m $COMPONENT \e[0m DNS Record Creation In Progress ******* !!!!!!"
    sed -e "s/COMPONENT/${COMPONENT}/" -e "s/IPADDRESS/${PRIVATE_IP}/" route53.json > /tmp/dns.json

    aws route53 change-resource-record-sets --hosted-zone-id $HOSTEDZONEID --change-batch file:///tmp/dns.json
    echo -e "******* \e[32m $COMPONENT \e[0m DNS Record Creation Is Complted ******* !!!!!!"
}

# If the user supplies all as the first argument, then all these servers will be created.
if [ "$1" == "all" ]; then 

    for component in mongodb catalogue cart user shipping frontend payment mysql redis rabbitmg; do 
        COMPONENT=$component 
        create_server 
    done 

else 
    create_ec2 
fi 