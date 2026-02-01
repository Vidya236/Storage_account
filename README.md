Storage_account deployment
# Update and install dependencies
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update && sudo apt-get install terraform

az login

git clone https://github.com/Vidya236/Storage_account.git
cd Storage_account

terraform init

# Create the workspaces
terraform workspace new dev
terraform workspace new stage

terraform workspace select dev
terraform import azurerm_resource_group.example /subscriptions/0a8b2482-9db4-4697-a9fe-fd7221606864/resourceGroups/shared-app-rg
terraform import azurerm_storage_account.example /subscriptions/0a8b2482-9db4-4697-a9fe-fd7221606864/resourceGroups/shared-app-rg/providers/Microsoft.Storage/storageAccounts/vidyadevstore2026v1
terraform import azurerm_storage_container.data https://vidyadevstore2026v1.blob.core.windows.net/data-container
terraform apply -auto-approve

terraform workspace select stage
terraform import azurerm_resource_group.example /subscriptions/0a8b2482-9db4-4697-a9fe-fd7221606864/resourceGroups/shared-app-rg
terraform import azurerm_storage_account.example /subscriptions/0a8b2482-9db4-4697-a9fe-fd7221606864/resourceGroups/shared-app-rg/providers/Microsoft.Storage/storageAccounts/vidyastagestore2026v1
terraform import azurerm_storage_container.data https://vidyastagestore2026v1.blob.core.windows.net/data-container
terraform apply -auto-approve

To see Dev credentials: terraform workspace select dev && terraform output
To see Stage credentials: terraform workspace select stage && terraform output


