 Connect-AzAccount -Tenant 'e1c5d9ee-a951-451e-8432-642c23d40071' -SubscriptionId '1d012c12-eb7c-4bc4-aba7-d34e5c20bf00'
 # Set the name of your App Service, storage account, and file share
$appServiceName = "rg-workspace-ui-app"
$storageAccountName = "rgworkspacesg"
$fileShareName = "mount"

# Set the destination path in the container
$containerPath = "/usr/share/nginx/html/assets"

# Get the resource group name and the name of the App Service plan
$webApp = Get-AzWebApp -Name $appServiceName
$resourceGroupName = $webApp.ResourceGroup
$appServicePlanName = $webApp.ServerFarmId

# Get the storage account key
$storageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName)[0].Value

# Add the storage account as a mount
Invoke-AzCliCommand -ScriptBlock {
    az webapp config storage-account add --resource-group $using:resourceGroupName --name $using:appServiceName --custom-id $using:storageAccountName --storage-type AzureFiles --share-name $using:fileShareName --account-name $using:storageAccountName --access-key $using:storageAccountKey --mount-path $using:containerPath
}

# Verify the storage is mounted
Invoke-AzCliCommand -ScriptBlock {
    az webapp config storage-account list --resource-group $using:resourceGroupName --name $using:appServiceName
}

