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
ls
