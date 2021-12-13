#Script to discover attributes & SPNs of multiple accounts with CSV Exporting optional

Import-Module ActiveDirectory

#Variables
$targetacc = Read-Host ("Enter Service accounts separated by commas") 
$targetacc = $targetacc.split(",")
$inc = Read-Host "Enter Incident number, e.g INC4203141"
$csvloc = Read-Host "Enter location for CSV Export, e.g D:\Temp"


ForEach ($acc in $targetacc) {

#Get AD Properties for Service Accounts

Write-Host "Checking details of $acc from Active Directory" -ForegroundColor Yellow
Write-Host ' '

Get-ADUser -Filter {sAMAccountName -like $acc} -Properties *  | Select-Object DisplayName, sAMAccountName, mail, manager, LastLogonDate, Whencreated, enabled, Description 
}



$input = Read-Host "Continue to SPN Check? Press 'Y', otherwise 'N' to exit"

switch ($input) {
'Y'{
#Check SPNS associated with Service Accounts
ForEach ($acc in $targetacc) {

Write-Host ''
Write-Host "Checking SPNs associated with $acc" -ForegroundColor Yellow
Write-Host ''
setspn -L $acc
}
}

'N'{
exit
}
'default'
{
`
}
}


#Export to CSV Function
$input = Read-Host "Export to CSV? Press 'Y', 'N' to exit"

switch ($input) {
'Y'{

ForEach ($acc in $targetacc) {
Get-ADUser -Filter {sAMAccountName -like $acc} -Properties *  | Select-Object DisplayName, sAMAccountName, mail, manager, LastLogonDate, enabled, Description | Export-Csv $csvloc\$inc.csv
}

ForEach ($acc in $targetacc) {

setspn -L $acc | Export-Csv $csvloc\$inc.csv -NoClobber -Append
}

Write-Host "CSV Exported '$csvloc\$inc.csv'"
}

'N'{
exit
}
'default'
{
exit
}
}
