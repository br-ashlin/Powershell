#Bulk Server and Port Network Scanning

$Ports  = "135","443","5286" 
$Servers = Get-Content servers.txt 
ForEach($Server in $Servers)
{
Foreach ($P in $Ports){
$check=Test-NetConnection $server -Port $P -WarningAction SilentlyContinue
$check | Select ComputerName, PingSucceeded, RemotePort, TcpTestSucceeded
}
}
