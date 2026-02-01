#!/bin/bash

# 1. Get the current Terraform workspace name
WORKSPACE=$(terraform workspace show)

echo "Detecting environment... Current Workspace: $WORKSPACE"

# 2. Set variables based on the workspace
if [ "$WORKSPACE" == "dev" ]; then
    RG_NAME="shared-app-rg"
    STORAGE_NAME="vidyadevstore2026v1"
elif [ "$WORKSPACE" == "stage" ]; then
    RG_NAME="shared-app-rg-stage"
    STORAGE_NAME="vidyastagestore2026v1"
else
    echo "Error: Unknown workspace '$WORKSPACE'. Please switch to 'dev' or 'stage'."
    exit 1
fi

# Common Subscription ID
SUB_ID="0a8b2482-9db4-4697-a9fe-fd7221606864"

echo "Step 1: Importing Resource Group [$RG_NAME]..."
terraform import azurerm_resource_group.example /subscriptions/$SUB_ID/resourceGroups/$RG_NAME

echo "Step 2: Importing Storage Account [$STORAGE_NAME]..."
terraform import azurerm_storage_account.example /subscriptions/$SUB_ID/resourceGroups/$RG_NAME/providers/Microsoft.Storage/storageAccounts/$STORAGE_NAME

echo "Success! Environment '$WORKSPACE' is now synced with Terraform."
