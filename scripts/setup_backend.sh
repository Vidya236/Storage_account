#!/usr/bin/bash

RESOURCE_GROUP_NAME="terraform-state-rg"
STAGE_SA_ACCOUNT="tfstageback2026vallika"
DEV_SA_ACCOUNT="tfdevbackend2026vidya23"
CONTAINER_NAME="tfstate"
LOCATION="southindia"

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Create storage accounts
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STAGE_SA_ACCOUNT --sku Standard_LRS --encryption-services blob
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $DEV_SA_ACCOUNT --sku Standard_LRS --encryption-services blob

# Create blob containers
az storage container create --name $CONTAINER_NAME --account-name $STAGE_SA_ACCOUNT
az storage container create --name $CONTAINER_NAME --account-name $DEV_SA_ACCOUNT

