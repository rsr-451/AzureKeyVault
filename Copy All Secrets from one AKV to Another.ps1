#######Powershell script for copying all secrets from one Azure Key Vault to another#####

# Variables for the source and destination Key Vault names
$sourceVaultName = "pot2"
$destVaultName = "pot3"

# Retrieve all secrets from the source Key Vault
$secrets = Get-AzKeyVaultSecret -VaultName $sourceVaultName

# Loop through each secret and copy it to the destination Key Vault
foreach ($secretMetadata in $secrets) {
    $secretName = $secretMetadata.Name
    
    # Retrieve the secret value from the source Key Vault using the secret name
    $secretValue = Get-AzKeyVaultSecret -VaultName $sourceVaultName -Name $secretName -AsPlainText
    
    # Log the secret name and value for debugging
    Write-Host "Secret Name: $secretName"
    Write-Host "Secret Value: $secretValue"
    
    # Check if the secret value is not null
    if ($null -ne $secretValue) {
        # Convert the secret value to a SecureString
        $secureSecretValue = ConvertTo-SecureString -String $secretValue -AsPlainText -Force
        
        # Set the secret value in the destination Key Vault
        Set-AzKeyVaultSecret -VaultName $destVaultName -Name $secretName -SecretValue $secureSecretValue
        Write-Host "Successfully copied secret: $secretName"
    } else {
        Write-Host "Secret '$secretName' has no value and will not be copied."
    }
}

