## This Script will copy the secret from source key vault to destination key vault
## Source key vault = pot0
## Destination key vault = pot1
## source secret = sec1
## destination secret = pot0secret
Install-Module Az.KeyVault
Connect-AzAccount
Get-AzKeyVaultSecret -VaultName "pot0"
$sourcesecvalue = Get-AzKeyVaultSecret -VaultName "pot0" -Name "sec1" -AsPlainText
$secretSecure = ConvertTo-SecureString -String $sourcesecvalue -AsPlainText -Force
Set-AzKeyVaultSecret -VaultName 'pot1' -Name 'pot0secret' -SecretValue $secretSecure
Get-AzKeyVaultSecret -VaultName 'pot1' -Name 'pot0secret' -AsPlainText

## Source key vault = pot1
## Destination key vault = pot0
## source secret = pot0secret
## destination secret = sec1

$sourcesecvalue = Get-AzKeyVaultSecret -VaultName "pot1" -Name "pot0secret" -AsPlainText
$secretSecure = ConvertTo-SecureString -String $sourcesecvalue -AsPlainText -Force
Set-AzKeyVaultSecret -VaultName 'pot0' -Name 'sec1' -SecretValue $secretSecure
Get-AzKeyVaultSecret -VaultName 'pot0' -Name 'sec1' -AsPlainText