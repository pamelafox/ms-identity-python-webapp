#!/bin/bash

echo 'Sourcing env'

# Read the .env file and extract the necessary env variables
source .env

if [ -z "$RESOURCE_GROUP_NAME" ]
then
  echo "RESOURCE_GROUP_NAME is not defined"
  exit 1
fi

if [ -z "$CLIENT_ID" ]
then
  echo "CLIENT_ID is not defined"
  exit 1
fi

az webapp config appsettings set \
  --resource-group $RESOURCE_GROUP_NAME \
  --name $WEB_NAME \
  --settings \
    CLIENT_ID=$CLIENT_ID \
    CLIENT_SECRET=$CLIENT_SECRET \
    TENANT_ID=$TENANT_ID \
    TENANT_NAME=$TENANT_NAME \
    SIGNUPSIGNIN_USER_FLOW=$SIGNUPSIGNIN_USER_FLOW \
    EDITPROFILE_USER_FLOW=$EDITPROFILE_USER_FLOW \
    RESETPASSWORD_USER_FLOW=$RESETPASSWORD_USER_FLOW 