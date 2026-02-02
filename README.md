Storage_account deployment
# Update and install dependencies
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update && sudo apt-get install terraform -y

az login

git clone https://github.com/Vidya236/Storage_account.git
cd Storage_account

terraform init

# Create the workspaces
terraform workspace new dev
terraform workspace new stage
# Switch initialization to Dev backend
terraform init -backend-config=dev.tfbackend -reconfigure
# Setting workspace to dev
terraform workspace select dev
# Switch initialization to Stage backend
terraform init -backend-config=stage.tfbackend -reconfigure

terraform import azurerm_resource_group.example /subscriptions/$SUB_ID/resourceGroups/shared-app-rg
terraform apply -auto-approve

To see Dev credentials: terraform workspace select dev && terraform output
To see Stage credentials: terraform workspace select stage && terraform output


