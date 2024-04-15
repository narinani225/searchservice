# Connect to Azure account (ensure you're logged in)
 #Connect-AzAccount -Tenant 'e1c5d9ee-a951-451e-8432-642c23d40071' -SubscriptionId '1d012c12-eb7c-4bc4-aba7-d34e5c20bf00'
 az login --tenant e1c5d9ee-a951-451e-8432-642c23d40071
  az account set --subscription "R and D Labs"
 # Set the name of your App Service, storage account, and file share
appServiceName = "rg-workspace-ui-app"
storageAccountName = "rgworkspacesg"

fileShareName = "mount"
# Set the destination path in the container
containerPath = "/usr/share/nginx/html/assets"
# Get the resource group name and the name of the App Service plan
resourceGroupName = "EwsArmDeploy"
appServicePlanName = "rg-workspace-serviceplan"
# Get the storage account key
storageAccountKey = "a5f+AK/Q974cBVEW7uRSR6zTLgo8HvkbvMLTtHZifL42M7TglsHLjN2dUhUR4q4F7cz8wzjmxK5r+AStKwmZAA=="
# Add the storage account as a mount

az webapp config storage-account add --resource-group $resourceGroupName --name $appServiceName --custom-id $storageAccountName --storage-type AzureFiles --share-name $fileShareName --account-name $storageAccountName --access-key $storageAccountKey --mount-path $containerPath
# Verify the storage is mounted
az webapp config storage-account list --resource-group $resourceGroupName --name $appServiceName
