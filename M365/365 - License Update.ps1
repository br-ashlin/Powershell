#Ben Ashlin - 365 License Update

#Account Details
$Creds = Get-Credentail

#Install & Connect to Azure AD
Install-Module AzureAD
Connect-AzureAD -Credential $Creds

#Install & Connect to MSOL
Install-Module MSOnline
Connect-MsolService -Credential $Creds

#Bulk User Get (CSV)
Import-CSV <Location> | Foreach {
$UPN = $_.UserPrincipalName
Set-MsolUserlicense -UserPrincipalName $UPN -AddLicenses "domain:LICENCE" #License like vmch:ENTERPRISEPACK
Set-MsolUser -UserPrincipalName $UPN -UsageLocation "AU" 
} 


#Bulk Get All Accounts with Following Attr
#Get-MsolUSer -All | Where {
#$_.UsageLocation -eq $null
#$_.UserType -eq $Member
#$_.isLicensed -eq $false}


