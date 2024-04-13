# Define variables
$resourceGroupName = "EwsArmDeploy"
$searchServiceName = "rgworkspacecognitivesearchtest"

# Get the admin API key
$adminApiKey = Get-AzSearchAdminKeyPair -ResourceGroupName $resourceGroupName -ServiceName $searchServiceName
$adminKey = $adminApiKey.primary

# Store the admin API key securely in Azure Key Vault
$adminSecret = ConvertTo-SecureString -String $adminKey -AsPlainText -Force
$secret = Set-AzKeyVaultSecret -VaultName "ews-keyvault-test" -Name "search-Service-API-Key" -SecretValue $adminSecret

# Define headers for REST API calls
$headers = @{
    'api-key' = $adminKey
    'Content-Type' = 'application/json'
    'Accept' = 'application/json'
}

# Define index request body
$indexBody = @{
    "name" = "azure-blob-blogs-index"
    "fields" = @(
        # Define fields
    )
} | ConvertTo-Json

# Define open AI index request body
$openAiIndexBody = @{
    "name" = "open-ai-index"
    "fields" = @(
        # Define fields
    )
} | ConvertTo-Json

# Define URLs for index and data source creation
$urlIndex = "https://$($searchServiceName).search.windows.net/indexes/azure-blob-blogs-index?api-version=2023-11-01"
$urlIndex1 = "https://$($searchServiceName).search.windows.net/indexes/open-ai-index?api-version=2023-11-01"
$urlDatasource = "https://$($searchServiceName).search.windows.net/datasources/azure-blob-datasource?api-version=2023-11-01"

# Create the index and data source
Invoke-RestMethod -Uri $urlIndex -Headers $headers -Method Put -Body $indexBody | ConvertTo-Json
Invoke-RestMethod -Uri $urlIndex1 -Headers $headers -Method Put -Body $openAiIndexBody | ConvertTo-Json

# Define data source request body
$datasourceBody = @{
    "name" = "azure-blob-datasource"
    "type" = "azureblob"
    "credentials" = @{
        "connectionString" = "DefaultEndpointsProtocol=https;AccountName=pmoblobstorageaccount;AccountKey=9x/DEVuXorrgsrqAsawRWRWBwE/UJ8bJUJceCthRzRteC5JnRBdH+GluJ1BGFF/A29A6LGu5tQKD+ASt+MO/bg==;EndpointSuffix=core.windows.net"
    }
    "container" = @{
        "name" = "dev-container-blob"
    }
} | ConvertTo-Json

# Create the data source
Invoke-RestMethod -Uri $urlDatasource -Headers $headers -Method Put -Body $datasourceBody | ConvertTo-Json
