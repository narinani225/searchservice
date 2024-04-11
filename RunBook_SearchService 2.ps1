Connect-AzAccount
# Set the correct Subscription ID
Set-AzContext -SubscriptionId "1d012c12-eb7c-4bc4-aba7-d34e5c20bf00"

$resourceGroupName = "EwsArmDeploy"
$searchServiceName = "rgworkspacecognitivesearch"
 
# Get the admin API key
$adminApiKey = Get-AzSearchAdminKeyPair -ResourceGroupName $resourceGroupName -ServiceName $searchServiceName
$adminkey = $adminApiKey.primary

# Store the admin API key in Azure Key Vault
$adminSecret = ConvertTo-SecureString -String $adminKey -AsPlainText -Force
$secret = Set-AzKeyVaultSecret -VaultName "ews-keyvault-test" -Name "search-Service-API-Key" -SecretValue $adminSecret

 
$headers = @{
    'api-key' = $adminkey
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
        @{
            "name" = "BlogOverview"
            "type" = "Edm.String"
            "searchable" = $true
            "filterable" = $false
            "sortable" = $false
            "facetable" = $false
            "key" = $false
        },
        @{
            "name" = "Keywords"
            "type" = "Edm.String"
            "searchable" = $true
            "filterable" = $false
            "sortable" = $false
            "facetable" = $false
            "key" = $false
        },
        @{
            "name" = "BlogStatus"
            "type" = "Edm.String"
            "searchable" = $true
            "filterable" = $true
            "sortable" = $true
            "facetable" = $true
            "key" = $false
        },
        @{
            "name" = "EvokeDepartment"
            "type" = "Edm.String"
            "searchable" = $true
            "filterable" = $true
            "sortable" = $true
            "facetable" = $true
            "key" = $false
        },
        @{
            "name" = "URLLink"
            "type" = "Edm.String"
            "searchable" = $false
            "filterable" = $false
            "sortable" = $false
            "facetable" = $false
            "key" = $false
        },
        @{
            "name" = "Date"
            "type" = "Edm.DateTimeOffset"
            "searchable" = $false
            "filterable" = $false
            "sortable" = $false
            "facetable" = $false
            "key" = $false
        },
        @{
            "name" = "WrittenBy"
            "type" = "Edm.String"
            "searchable" = $true
            "filterable" = $true
            "sortable" = $true
            "facetable" = $true
            "key" = $false
        },
        @{
            "name" = "ItemType"
            "type" = "Edm.String"
            "searchable" = $true
            "filterable" = $false
            "sortable" = $false
            "facetable" = $false
            "key" = $false
        },
        @{
            "name" = "Path"
            "type" = "Edm.String"
            "searchable" = $true
            "filterable" = $false
            "sortable" = $false
            "facetable" = $false
            "key" = $false
        },
        @{
            "name" = "AzureSearch_DocumentKey"
            "type" = "Edm.String"
            "searchable" = $true
            "filterable" = $false
            "sortable" = $false
            "facetable" = $false
            "key" = $true
        },
        @{
            "name" = "DataSource"
            "type" = "Edm.String"
            "searchable" = $true
            "filterable" = $true
            "sortable" = $true
            "facetable" = $true
            "key" = $false
        }
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
        @{
            "name" = "filepath"
            "type" = "Edm.String"
            "searchable" = $false
            "filterable" = $false
            "retrievable" = $true
            "sortable" = $false
            "facetable" = $false
            "key" = $false
        },
        @{
            "name" = "title"
            "type" = "Edm.String"
            "searchable" = $true
            "filterable" = $false
            "retrievable" = $true
            "sortable" = $false
            "facetable" = $false
            "key" = $false
        },
        @{
            "name" = "url"
            "type" = "Edm.String"
            "searchable" = $false
            "filterable" = $false
            "retrievable" = $true
            "sortable" = $false
            "facetable" = $false
            "key" = $false
        },
        @{
            "name" = "id"
            "type" = "Edm.String"
            "searchable" = $false
            "filterable" = $true
            "retrievable" = $true
            "sortable" = $true
            "facetable" = $false
            "key" = $true
        },
        @{
            "name" = "chunk_id"
            "type" = "Edm.String"
            "searchable" = $false
            "filterable" = $false
            "retrievable" = $true
            "sortable" = $false
            "facetable" = $false
            "key" = $false
        },
        @{
            "name" = "last_updated"
            "type" = "Edm.String"
            "searchable" = $false
            "filterable" = $false
            "retrievable" = $true
            "sortable" = $false
            "facetable" = $false
            "key" = $false
        }
    )
} | ConvertTo-Json
 
 
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
