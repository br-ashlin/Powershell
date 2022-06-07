#Ben Ashlin - Get-Mailboxes per OU and Export required data to CSV for Office365 Licensing.

#Specify OU required here
$OU = "xx"

#Specify Mail Server Here
$MS = "xxx"

#Specify Location of CSV Output Folder
$CSV = "xxx"

#Connect To Mail Server & Add Exchange shell Snapin


#Get Mailbox per OU and Export to CSV
Get-Mailbox -OrganizationalUnit $OU | Select DisplayName, SAMAccountName | Export-Csv -Path "$CSV$OU.csv "
