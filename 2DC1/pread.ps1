# Powershell script to prepare server for AD install/setup
# Created by Gnome787  | 24 SEP 22

# Disable IPv6
Disable-NetAdapterBinding -Name $using:IntName -ComponentID 'ms_tcpip6' | Out-Null

Write-Host "IPv6 Disabled" -ForegroundColor Cyan

# Set the IP address of the interface to a static address
New-NetIPAddress -InterfaceAlias $using:IntName -IPAddress $using:DC1IP -Prefix $using:Prefix -DefaultGateway $using:Gateway | Out-Null

# Print output
Write-Host "Server has been assigned an IP of $using:DC1IP" -ForegroundColor Cyan
Write-Host "Server has been assigned a Default Gateway of $using:Gateway" -ForegroundColor Cyan

# Change DNS server to our server
Set-DnsClientServerAddress -InterfaceAlias $using:IntName -ServerAddress $using:DC1IP | Out-Null

# Print output
Write-Host "Server has been assigned a DNS address of $using:DC1IP" -ForegroundColor Cyan

# Powershell script to install AD & promote server to DC
# Created by Gnome787  | 24 SEP 22

# Install AD DS
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools | Out-Null
Write-Host "AD DS has been installed" -ForegroundColor Cyan
Write-Host "Setting up AD DS Forest" -ForegroundColor Cyan

# Import Active Directory
Import-Module ADDSDeployment | Out-Null

# Install AD DS Forest
Install-ADDSForest -DomainName $using:DomainName -SafeModeAdministratorPassword $using:Password -InstallDNS:$true -Force:$true -WarningAction SilentlyContinue | Out-Null

Write-Progress -Id 0 -Completed -Activity -1 | Out-Null