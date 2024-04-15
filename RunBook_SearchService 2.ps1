 #Connect-AzAccount -Tenant 'e1c5d9ee-a951-451e-8432-642c23d40071' -SubscriptionId '1d012c12-eb7c-4bc4-aba7-d34e5c20bf00'
 az login --tenant e1c5d9ee-a951-451e-8432-642c23d40071
  az account set --subscription "R and D Labs"
 # Add the storage account as a mount

az webapp config storage-account add --resource-group "rg-workspace-ui-app" --name "rg-workspace-ui-app" --custom-id "rgworkspacesg" --storage-type AzureFiles --share-name "mount" --account-name "rgworkspacesg" --access-key "a5f+AK/Q974cBVEW7uRSR6zTLgo8HvkbvMLTtHZifL42M7TglsHLjN2dUhUR4q4F7cz8wzjmxK5r+AStKwmZAA==" --mount-path "/usr/share/nginx/html/assets"
# Verify the storage is mounted
#az webapp con
