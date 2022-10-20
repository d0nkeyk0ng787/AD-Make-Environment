# Install CLI1 

# Disable IPv6
Disable-NetAdapterBinding -Name $using:IntName -ComponentID 'ms_tcpip6' | Out-Null

Write-Host "IPv6 Disabled" -ForegroundColor Cyan

# Set the DNS
Set-DNSClientServerAddress -InterfaceAlias $using:IntName -ServerAddresses $using:DC1IP

Write-Host "Clients DNS server was changed to $using:DC1IP" -ForegroundColor Cyan

Write-Host "Joining client to the domain" -ForegroundColor Cyan

Start-Sleep 60

# Join computer to the domain
$domainparams = @{
	DomainName = $using:DomainName
	NewName = $using:CLI1
	OUPath = "OU=Workstations,OU=Devices,OU=XYZ,DC=xyz,DC=local"
	Credential = $using:DomainCred
	Force = $true
	Restart = $true
}

Add-Computer @domainparams | Out-Null
