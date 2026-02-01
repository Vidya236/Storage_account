#!/bin/bash

# --- CONFIGURATION ---
SUB_ID="0a8b2482-9db4-4697-a9fe-fd7221606864"
RG_NAME="shared-app-rg"
RG_ID="/subscriptions/$SUB_ID/resourceGroups/$RG_NAME"

echo "🗑️  Cleaning local Terraform state..."
rm -rf .terraform/
rm -f .terraform.lock.hcl terraform.tfstate*

echo "🚀 Initializing Terraform..."
terraform init

# --- DEPLOYMENT FUNCTION ---
deploy_env() {
    local ENV=$1
    local STOR_NAME=$2

    echo "---------------------------------------"
    echo "🌍 Setting up environment: $ENV"
    echo "---------------------------------------"

    # 1. Create and select workspace
    terraform workspace new $ENV || terraform workspace select $ENV

    # 2. Import existing foundation (RG, Storage, and Container)
    echo "📦 Importing existing resources for $ENV..."

    # Import Resource Group
    terraform import azurerm_resource_group.example $RG_ID

    # Import Storage Account
    terraform import azurerm_storage_account.example $RG_ID/providers/Microsoft.Storage/storageAccounts/$STOR_NAME

    # Import Storage Container (Required because we added it to main.tf)
    terraform import azurerm_storage_container.data https://$STOR_NAME.blob.core.windows.net/data-container

    # 3. Apply to create the Identity, Secret, and Role Assignments
    echo "🛠️  Applying Identity and RBAC logic..."
    terraform apply -auto-approve
}

# --- EXECUTION ---

# Run for Dev
deploy_env "dev" "vidyadevstore2026v1"

# Run for Stage
deploy_env "stage" "vidyastagestore2026v1"

echo "✅ All environments successfully reset and synced!"
