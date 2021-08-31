#Check AD Domain functional Level per DC
repadmin.exe /showattr *.sub.domain.tld "dc=sub,dc=domain,dc=tld" /atts:msDS-Behavior-Version

#check for the password reset on the built-in krbtgt account.
repadmin.exe /showattr *.sub.domain.tld "cn=krbtgt,cn=users,dc=sub,dc=domain,dc=tld" /atts:pwdLastSet


#Check KRBTGT Accounts in Forest, PasswordLastSet

import-module activedirectory
$ADForestRootDomain = (Get-ADForest).RootDomain
$AllADForestDomains = (Get-ADForest).Domains
$ForestKRBTGTInfo = @()
ForEach ($AllADForestDomainsItem in $AllADForestDomains)
{
[string]$DomainDC = (Get-ADDomainController -Discover -Force -Service “PrimaryDC” -DomainName $AllADForestDomainsItem).HostName
[array]$ForestKRBTGTInfo += Get-ADUser -Filter 'Name -Like "krbtgt*"' -Server $DomainDC -Prop Name,Created,logonCount,Modified,PasswordLastSet,PasswordExpired,msDS-KeyVersionNumber,CanonicalName,msDS-KrbTgtLinkBl
}
$ForestKRBTGTInfo | Select Name,Created,logonCount,PasswordLastSet,PasswordExpired,msDS-KeyVersionNumber,CanonicalName | ft -auto


#Track GPO changes originating server

#Get GPO ID
Get-GPO -Name <Name> -Domain <Domain> 
#Select ID

repadmin /showmeta . "CN={GPO ID},CN=policies,CN=system,dc=adsec,dc=lab,dc=com"
