# Install Git using Chocolatey
Write-Host "Installing Git..."
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install git -y

# Wait for Git installation to complete before proceeding
Write-Host "Waiting for Git installation to complete..."
Start-Sleep -Seconds 30  # Adjust sleep duration as needed

$resourceGroupName = "EwsArmDeploy"
$searchServiceName = "rgworkspacecognitivesearchtest"

# Get the admin API key
$adminApiKey = Get-AzSearchAdminKeyPair -ResourceGroupName $resourceGroupName -ServiceName $searchServiceName
$adminKey = $adminApiKey.primary

# Store the admin API key in Azure Key Vault
$adminSecret = ConvertTo-SecureString -String $adminKey -AsPlainText -Force
$secret = Set-AzKeyVaultSecret -VaultName "rg-workspace-keyvault" -Name "search-Service-API-Key" -SecretValue $adminSecret

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
        },
        # Add other fields here as needed
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
        },
        # Add other fields here as needed
    )
} | ConvertTo-Json

# URL for index creation
$urlIndex = "https://$($searchServiceName).search.windows.net/indexes/azure-blob-blogs-index?api-version=2023-11-01"
$urlIndex1 = "https://$($searchServiceName).search.windows.net/indexes/open-ai-index?api-version=2023-11-01"

# Create the index
Invoke-RestMethod -Uri $urlIndex -Headers $headers -Method Put -Body $indexBody | ConvertTo-Json
Invoke-RestMethod -Uri $urlIndex1 -Headers $headers -Method Put -Body $openAiIndexBody | ConvertTo-Json

# Create datasource request body
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

$urlDatasource = "https://$($searchServiceName).search.windows.net/datasources/azure-blob-datasource?api-version=2023-11-01"

# Create the datasource
Invoke-RestMethod -Uri $urlDatasource -Headers $headers -Method Put -Body $datasourceBody | ConvertTo-Json
