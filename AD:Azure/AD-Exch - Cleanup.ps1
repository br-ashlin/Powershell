##############################
#       Ben Ashlin           #
# AD & MBX by Cleanup by CSV #
#       February, 2019       #
#           V1.0             #
#                            #
#                            #
##############################

#Pre-Requisites
# a. Ensure sure you have a valid, & working Backup of Exchange Databases / Mailboxes
# b. Ensure AD Recycle Bin is enabled (Requires Forest Functional Level 2k08 or higher)

# 1. Process is 'users' within CSV containing attribute 'sAMAccountName' to be migrated to $TargetOU specified by technician
# 2. After users have been migrated, script will Disable 'Protect from Accidental Deletion' at OU level
# 3. Users within $Target OU will have 'Inherited Permissions' enabled to allow for Exchange mailbox removal permissions.
# 4. Exchange PS Snapin loaded, Users in CSV file queried by 'Name' field and Mailbox Removal process begins. (Remove-Mailbox cmdlet Removes AD Account).


Import-Module ActiveDirectory

# Specify target OU.
$TargetOU = "OU=Disabled2019,OU=Genusers,DC=gen,DC=vic,DC=edu,DC=au"

# Read user sAMAccountNames from csv file (field labeled "Name").
$users= Import-Csv -Path C:\Imports\Disabled2019.csv
   
foreach ($user in $users) {
Get-ADUser $User.Name | Move-ADObject -TargetPath $TargetOU }

#Disable Protect From Accidental Deletion by OU
$users = Get-ADUser -ldapfilter “(objectclass=user)” -searchbase "$TargetOU"
ForEach($user in $users) {
Set-ADObject -Identity $user -ProtectedFromAccidentalDeletion:$false
}

#Set Inherited Permissions by OU
ForEach($user in $users)
{
    # Binding the users to DS
    $ou = [ADSI](“LDAP://” + $user)
    $sec = $ou.psbase.objectSecurity
 
    if ($sec.get_AreAccessRulesProtected())
    {
        $isProtected = $false ## allows inheritance
        $preserveInheritance = $true ## preserver inhreited rules
        $sec.SetAccessRuleProtection($isProtected, $preserveInheritance)
        $ou.psbase.commitchanges()
        Write-Host “$user is now inherting permissions”;
    }
    else
    {
        Write-Host “$User Inheritable Permission already set”
    }
}

#Cleanup Accounts by CSV (Applies to Exchange Mailboxes and AD Accounts)
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.SnapIn;
$users = Import-Csv "C:\RTG\Disabled2019.csv" 

foreach ($user in $users) {
Remove-Mailbox -Identity $user.Name -Permanent $true -Confirm:$false -Force
}
 