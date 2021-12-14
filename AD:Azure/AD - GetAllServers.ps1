#Get Computers within the Domain that is OperatingSystem like Server and Enabled.
#Queries are split into smaller segments depending on how large the environment is.


import-module Activedirectory
$a2d = Get-ADComputer -Filter { Name -ge "a" -and name -le "d" -and Operatingsystem -like "*Server*" -and Enabled -eq $true } -Properties OperatingSystem, LastLogonDate| Select-Object Name, dnshostName, Operatingsystem, LastLogonDate | Sort-Object Name
$d2m = Get-ADComputer -Filter { Name -ge "d" -and name -le "m" -and Operatingsystem -like "*Server*" -and Enabled -eq $true } -Properties OperatingSystem, LastLogonDate| Select-Object Name, dnshostName, Operatingsystem, LastLogonDate | Sort-Object Name
$m2s = Get-ADComputer -Filter { Name -ge "m" -and name -le "s" -and Operatingsystem -like "*Server*" -and Enabled -eq $true } -Properties OperatingSystem, LastLogonDate| Select-Object Name, dnshostName, Operatingsystem, LastLogonDate | Sort-Object Name
$s2z = Get-ADComputer -Filter { Name -ge "s" -and Operatingsystem -like "*Server*" -and Enabled -eq $true } -Properties OperatingSystem, LastLogonDate| Select-Object Name, dnshostName, Operatingsystem, LastLogonDate | Sort-Object Name


$a2d.count
$d2m.count
$m2s.count
$s2z.count

Clear-Variable -Name servers
$servers += $a2d + $d2m + $m2s+ $s2z
$servers | Export-CSV D:\ISO\BA\PS\AD_Servers_Export_14-12-21.csv
