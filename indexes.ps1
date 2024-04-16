Connect-AzAccount

# Set the correct Subscription ID
Set-AzContext -SubscriptionId "1d012c12-eb7c-4bc4-aba7-d34e5c20bf00"


$resourceGroupName = "EwsArmDeploy"
$searchServiceName = "rgworkspacecognitivesearch"

# Retrieve the admin API key from Azure Key Vault
$adminKey = (Get-AzKeyVaultSecret -VaultName "rg-workspace-keyvault" -Name "search-Service-API-Key").SecretValueText

$headers = @{
    'api-key' = $adminKey
    'Content-Type' = 'application/json'
    'Accept' = 'application/json'
}

# Create index request body
$indexBody = @{
    "name" = "azure-blob-blogs-index"
    "fields" = @(
        @{
            "name" = "BlogTitle"
            "type" = "Edm.String"
            "searchable" = $true
            "filterable" = $false
            "sortable" = $false
            "facetable" = $false
            "key" = $false
        }
        # Add other fields as needed
    )
} | ConvertTo-Json

$openAiIndexBody = @{
    "name" = "open-ai-index"
    "fields" = @(
        @{
            "name" = "content"
            "type" = "Edm.String"
            "searchable" = $true
            "filterable" = $false
            "retrievable" = $true
            "sortable" = $false
            "facetable" = $false
            "key" = $false
        }
        # Add other fields as needed
    )
} | ConvertTo-Json

$urlIndex = "https://$($searchServiceName).search.windows.net/indexes/azure-blob-blogs-index?api-version=2023-11-01"
$urlIndex1 = "https://$($searchServiceName).search.windows.net/indexes/open-ai-index?api-version=2023-11-01"

# Create the index
Invoke-RestMethod -Uri $urlIndex -Headers $headers -Method Put -Body $indexBody | ConvertTo-Json
Invoke-RestMethod -Uri $urlIndex1 -Headers $headers -Method Put -Body $openAiIndexBody | ConvertTo-Json
