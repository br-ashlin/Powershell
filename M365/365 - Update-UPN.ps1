#To update the username, follow these additional steps:
#Open PowerShell
#Connect to the online service with the following commands:

$msolcred = get-credential

connect-msolservice -credential $msolcred
#(Note: Enter your Office 365 credentials when prompted)

#Get affected user by UPN
Get-MsolUser -UserPrincipalName user@domain.onmicrosoft.com

#Enter the command to update the user name: 
Set-MsolUserPrincipalName -UserPrincipalName user@domain.onmicrosoft.com -NewUserPrincipalName user@domain
