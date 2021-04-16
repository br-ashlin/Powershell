#Ben Ashlin - Duplicate Mailboxes in Hybrid Environment

#Set Exchange Attributes to O365
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.SnapIn;
Import-Csv "C:\Scripts\Users.csv" |
foreach {
$Mailbox = $_.Mailbox
$Username = $_.Username
$Remote = $_.Remote
Disable-Mailbox $_.Mailbox -Confirm:$False
Enable-RemoteMailbox $_.Username -RemoteRoutingAddress $_.Remote }
 
#Set AD Attributes to O365
Import-Module ActiveDirectory 
Import-Csv "C:\Scripts\Users.csv" |
foreach {
$Username = $_.Username
Set-ADUser $Username –Replace @{msExchRecipientDisplayType = "-2147483642"} -ErrorAction Continue
Set-ADUser $Username –Replace @{msExchRecipientTypeDetails = "2147483648"}  -ErrorAction Continue
Set-ADUser $Username –Replace @{msExchRemoteRecipientType = "4"} -ErrorAction Continue }
