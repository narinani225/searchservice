write-host $pwd
# Set the API URL
$apiUrl = "https://rg-workspace-api-app.azurewebsites.net/api"

# Create the JSON object
$jsonObject = @{
    "API_URL" = $apiUrl
}

# Convert the JSON object to a string
$jsonString = $jsonObject | ConvertTo-Json

# Write the JSON string to a file
$jsonString | Out-File -FilePath "api-url.json"

# Replace these values with your own
$storageAccountName = "rgworkspacesg"
$resourceGroupName = "EwsArmDeploy"
$fileShareName = "mount"
$localFilePath = "api-url.json"
$remoteFileName = "api-url.json"
 
# Get the storage account key
$storageAccountKey = "a5f+AK/Q974cBVEW7uRSR6zTLgo8HvkbvMLTtHZifL42M7TglsHLjN2dUhUR4q4F7cz8wzjmxK5r+AStKwmZAA=="
 
# Create the storage context
$storageContext = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey
 
# Upload the file to the file share
Set-AzStorageFileContent -Context $storageContext -ShareName $fileShareName -Source $localFilePath -Path $remoteFileName
