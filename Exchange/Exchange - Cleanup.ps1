#Script to cleanup mailboxes of users in CSV File


Add-PSSnapin Microsoft.Exchange.Management.PowerShell.SnapIn;
Import-Csv "x " | 
foreach {
$Username = $_.Username
$Location = $_.Location
}

#Mailbox Export
#Check the status of your exports by using 'Get-MailboxExportRequest | Get-MailboxExportRequestStatistics'
New-Mailbox-ExportRequest -Mailbox -FilePath "$Location" -Priority Emergency

#Disable Mailboxes
Disable-Mailbox -Identity $Username


