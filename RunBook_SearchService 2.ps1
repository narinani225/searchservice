# Connect to Azure account (ensure you're logged in)
 Connect-AzAccount -Tenant '' -SubscriptionId ''
 # Set the name of your App Service, storage account, and file share
$appServiceName = "rg-workspace-ui-app"
$storageAccountName = "rgworkspacesg"

$fileShareName = "mount"
# Set the destination path in the container
$containerPath = "/usr/share/nginx/html/assets"
# Get the resource group name and the name of the App Service plan
$resourceGroupName = "EwsArmDeploy"
$appServicePlanName = "rg-workspace-serviceplan"
# Get the storage account key
$storageAccountKey = "a5f+AK/Q974cBVEW7uRSR6zTLgo8HvkbvMLTtHZifL42M7TglsHLjN2dUhUR4q4F7cz8wzjmxK5r+AStKwmZAA=="
# Add the storage account as a mount


# Construct the storage account properties
$storageAccountProperties = @{
    "CustomId" = $storageAccountName
    "StorageType" = "AzureFiles"
    "ShareName" = $fileShareName
    "AccountName" = $storageAccountName
    "AccessKey" = $storageAccountKey
    "MountPath" = $containerPath
}

# Add the storage account as a mount
Add-AzWebAppStorageAccount -ResourceGroupName $resourceGroupName -Name $appServiceName -CustomId $storageAccountName -StorageType AzureFiles -ShareName $fileShareName -AccountName $storageAccountName -AccessKey $storageAccountKey -MountPath $containerPath

# Verify the storage is mounted
Get-AzWebAppStorageAccount -ResourceGroupName $resourceGroupName -Name $appServiceName
