
$Creds = Get-Credential

#Install & Connect to Azure AD
Install-Module AzureAD
Connect-AzureAD -Credential $Creds

#Install & Connect to MSOL
Install-Module MSOnline
Connect-MsolService -Credential $Creds