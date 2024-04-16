param (
    [string]$sourceResourceGroupName2,
    [string]$sourceStorageAccountName2,
    [string]$destinationResourceGroupName,
    [string]$destinationStorageAccountName,
    [string]$subscriptionId,
    [string]$sourceContainerName
)

# Connect to Azure
Connect-AzAccount
Set-AzContext -SubscriptionId $subscriptionId

# Get storage account keys
$sourceStorageAccountKey2 = (Get-AzStorageAccountKey -ResourceGroupName $sourceResourceGroupName2 -AccountName $sourceStorageAccountName2)[0].Value
$destinationStorageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $destinationResourceGroupName -AccountName $destinationStorageAccountName)[0].Value

# Function to copy files from source storage account to destination storage account
function Copy-Files {
    param (
        [string]$sourceStorageAccountName,
        [string]$sourceResourceGroupName,
        [string]$sourceStorageAccountKey,
        [string]$destinationStorageAccountName,
        [string]$destinationResourceGroupName,
        [string]$destinationStorageAccountKey,
        [string]$sourceContainerName
    )
    
    # Create corresponding container in the destination storage account
    New-AzStorageContainer -Name $sourceContainerName -Context (New-AzStorageContext -StorageAccountName $destinationStorageAccountName -StorageAccountKey $destinationStorageAccountKey) -ErrorAction SilentlyContinue

    # Get blobs in the source container
    $blobs = Get-AzStorageBlob -Container $sourceContainerName -Context (New-AzStorageContext -StorageAccountName $sourceStorageAccountName -StorageAccountKey $sourceStorageAccountKey)

    # Copy blobs to destination container
    foreach ($blob in $blobs) {
        $blobName = $blob.Name
        Write-Host "Copying blob: $blobName"
        Start-AzStorageBlobCopy -Context (New-AzStorageContext -StorageAccountName $sourceStorageAccountName -StorageAccountKey $sourceStorageAccountKey) -SrcContainer $sourceContainerName -SrcBlob $blobName -DestContainer $sourceContainerName -DestBlob $blobName -DestContext (New-AzStorageContext -StorageAccountName $destinationStorageAccountName -StorageAccountKey $destinationStorageAccountKey) -Force
    }
}

# Copy files from the second source storage account
Copy-Files -sourceStorageAccountName $sourceStorageAccountName2 -sourceResourceGroupName $sourceResourceGroupName2 -sourceStorageAccountKey $sourceStorageAccountKey2 `
    -destinationStorageAccountName $destinationStorageAccountName -destinationResourceGroupName $destinationResourceGroupName -destinationStorageAccountKey $destinationStorageAccountKey -sourceContainerName $sourceContainerName
