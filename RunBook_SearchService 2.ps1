# Set the name of your App Service, storage account, and file share
$appServiceName = "rg-workspace-ui-app"
$storageAccountName = "rgworkspacesg"
$fileShareName = "mount"
# Set the destination path in the container
$containerPath = "/usr/share/nginx/html/assets"
# Get the resource group name and the name of the App Service plan
$resourceGroupName = (Get-AzWebApp -Name $appServiceName).ResourceGroup
$appServicePlanName = (Get-AzWebApp -Name $appServiceName).ServerFarm
# Get the storage account key
$storageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName)[0].Value
# Add the storage account as a mount
Set-AzWebApp -Name $appServiceName -ResourceGroupName $resourceGroupName -MountEntry $storageAccountName `
    -AccountName $storageAccountName -ShareName $fileShareName -AccessKey $storageAccountKey -Type AzureFiles `
    -CustomId $storageAccountName -DestinationPath $containerPath
# Verify the storage is mounted
Get-AzWebApp -Name $appServiceName -ResourceGroupName $resourceGroupName | Select-Object -ExpandProperty MountEntries
