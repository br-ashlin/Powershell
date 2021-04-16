#To remove a user in O365 that may be causing a duplicatation issue, follow these additional steps:
#Open PowerShell
#Connect to the online service with the following commands:

$msolcred = get-credential

connect-msolservice -credential $msolcred
#(Note: Enter your Office 365 credentials when prompted)

#Get affected user by UPN
Get-MsolUser -UserPrincipalName user@domain

#Enter the command to move the user to the recycle bin: 
Remove-MsolUser -UserPrincipalName user@domain -Force

#Return items in Recycle Bin
Get-msoluser -ReturnDeletedUsers

#Find and remove user from Recycle bin - This is irreversible 
Remove-MsolUser -UserPrincipalName user@domain -RemoveFromRecycleBin
