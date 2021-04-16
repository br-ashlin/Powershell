#Ben Ashlin - Get-Mailboxes per OU and Export required data to CSV for Office365 Licensing.

#Specify OU required here
$OU = "catholic.int/VMCH/Sites/Ballarat/Users"

#Specify Mail Server Here
$MS = "cath-mail01"

#Specify Location of CSV Output Folder
$CSV = "\\cath-mail01\I$\CSV-Export"

#Connect To Mail Server & Add Exchange shell Snapin


#Get Mailbox per OU and Export to CSV
Get-Mailbox -OrganizationalUnit $OU | Select DisplayName, SAMAccountName | Export-Csv -Path "$CSV$OU.csv "
