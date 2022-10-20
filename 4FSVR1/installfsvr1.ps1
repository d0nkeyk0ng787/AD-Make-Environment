# Install FSVR1

# Disable IPv6
Disable-NetAdapterBinding -Name $using:IntName -ComponentID 'ms_tcpip6' | Out-Null

Write-Host "IPv6 Disabled" -ForegroundColor Cyan

# Assign a static IP
$ipparams = @{
    InterfaceIndex = (Get-NetAdapter).InterfaceIndex
    IPAddress = $using:FSVR1IP
	PrefixLength = $using:Prefix
	DefaultGateway = $using:Gateway
}

New-NetIPAddress @ipparams | Out-Null

# Completed message
Write-Host "Server has been assigned an IP of $using:FSVR1IP" -ForegroundColor Cyan
Write-Host "Server has been assigned a Default Gateway of $using:Gateway" -ForegroundColor Cyan

# Change the DNS server to DC1 
Set-DnsClientServerAddress -InterfaceAlias (Get-NetAdapter).name -ServerAddresses $using:DC1IP | Out-Null

# Completed message
Write-Host "Servers DNS server has been changed to $using:DC1IP" -ForegroundColor Cyan

Start-Sleep -Seconds 5

Write-Host "Joining server to the domain" -ForegroundColor Cyan

# Join computer to the domain
$domainparams = @{
	DomainName = $using:DomainName
	OUPath = "OU=Servers,OU=Devices,OU=XYZ,DC=xyz,DC=local"
	Credential = $using:DomainCred
	Force = $true
	Restart = $true
}

Add-Computer @domainparams | Out-Null