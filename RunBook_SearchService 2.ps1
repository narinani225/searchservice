# Set variables
appServiceName="rg-workspace-ui-app"
storageAccountName="rgworkspacesg"
fileShareName="mounttest"
containerPath="/usr/share/nginx/html/assets"

# Get resource group name
resourceGroupName=$(az webapp show --name $appServiceName --query 'resourceGroup' -o tsv)

# Get storage account key
storageAccountKey=$(az storage account keys list --resource-group $resourceGroupName --account-name $storageAccountName --query '[0].value' -o tsv)

# Add storage account as mount
az webapp config storage-account add \
    --resource-group $resourceGroupName \
    --name $appServiceName \
    --custom-id $storageAccountName \
    --storage-type AzureFiles \
    --share-name $fileShareName \
    --account-name $storageAccountName \
    --access-key $storageAccountKey \
    --mount-path $containerPath

# Verify storage mount
az webapp config storage-account list \
    --resource-group $resourceGroupName \
    --name $appServiceName
