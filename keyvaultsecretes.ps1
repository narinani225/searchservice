# Connect to Azure Account using a Microsoft identity
#Connect-AzAccount -UseDeviceAuthentication
Connect-AzAccount
Set-AzContext -SubscriptionId "1d012c12-eb7c-4bc4-aba7-d34e5c20bf00"
# Microsoft AD application
$appName = "ARM_WorkspaceSearch"
$keyVaultName = "rg-workspace-keyvault"  # Replace with your Key Vault name

try {
    # Get the current subscription ID
    $subscriptionId = (Get-AzContext).Subscription.Id

    # Retrieve the tenant ID
    $tenantId = (Get-AzContext).Tenant.Id

    # Get the Azure AD Application
    $appRegistration = Get-AzADApplication -DisplayName $appName -ErrorAction Stop

    # Retrieve the client ID (application ID)
    $clientId = $appRegistration.AppId

    # Generate a new GUID for the client secret
    $secret = [guid]::NewGuid().ToString()

    # Convert secret to SecureString
    $secureSecret = ConvertTo-SecureString -String $secret -AsPlainText -Force

    # Store the secrets in Azure Key Vault
    Set-AzKeyVaultSecret -VaultName $keyVaultName -Name "SubscriptionId" -SecretValue (ConvertTo-SecureString -String $subscriptionId -AsPlainText -Force) -ContentType "PlainText"
    Set-AzKeyVaultSecret -VaultName $keyVaultName -Name "TenantId" -SecretValue (ConvertTo-SecureString -String $tenantId -AsPlainText -Force) -ContentType "PlainText"
    Set-AzKeyVaultSecret -VaultName $keyVaultName -Name "ClientId" -SecretValue (ConvertTo-SecureString -String $clientId -AsPlainText -Force) -ContentType "PlainText"
    Set-AzKeyVaultSecret -VaultName $keyVaultName -Name "ClientSecret" -SecretValue $secureSecret

    # Display the results
    Write-Host "Microsoft Subscription ID: $subscriptionId"
    Write-Host "Microsoft Tenant ID: $tenantId"
    Write-Host "Microsoft Client ID (Application ID): $clientId"
    Write-Host "Microsoft Client Secret: $secret"

} catch {
    Write-Host "Error retrieving Azure AD application or setting Key Vault secrets: $_"
}
