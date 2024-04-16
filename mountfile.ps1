param (
    [string]$ApiUrl,
    [string]$StorageAccountName,
    [string]$StorageAccountKey,
    [string]$ResourceGroupName,
    [string]$FileShareName,
    [string]$LocalFilePath,
    [string]$RemoteFileName
)

# Set the JSON object with the API URL
$jsonObject = @{
    "API_URL" = $ApiUrl
}

# Convert the JSON object to a string
$jsonString = $jsonObject | ConvertTo-Json

# Write the JSON string to a file
$jsonString | Out-File -FilePath $LocalFilePath

# Create the storage context
$storageContext = New-AzStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey

# Upload the file to the file share
Set-AzStorageFileContent -Context $storageContext -ShareName $FileShareName -Source $LocalFilePath -Path $RemoteFileName