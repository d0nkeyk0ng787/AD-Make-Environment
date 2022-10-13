# Powershell script to prepare server for AD install/setup
# Created by Gnome787  | 24 SEP 22

# Disable IPv6
Disable-NetAdapterBinding -Name 'Ethernet' -ComponentID 'ms_tcpip6' | Out-Null

Write-Host "IPv6 Disabled" -ForegroundColor Cyan

# Create variables for static IP
$IntName = "Ethernet"
$Gateway = "192.168.100.1"
$SVRIP = "192.168.100.2"
$PrefixLen = "24"

# Set the IP address of the interface to a static address
New-NetIPAddress -InterfaceAlias $IntName -IPAddress $SVRIP -Prefix $PrefixLen -DefaultGateway $Gateway | Out-Null

# Print output
Write-Host "Server has been assigned an IP of $SVRIP" -ForegroundColor Cyan
Write-Host "Server has been assigned a Default Gateway of $Gateway" -ForegroundColor Cyan

# Change DNS server to our server
Set-DnsClientServerAddress -InterfaceAlias $IntName -ServerAddress $SVRIP | Out-Null

# Print output
Write-Host "Server has been assigned a DNS address of $SVRIP" -ForegroundColor Cyan

# Powershell script to install AD & promote server to DC
# Created by Gnome787  | 24 SEP 22

# Install AD DS
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools | Out-Null
Write-Host "AD DS has been installed" -ForegroundColor Cyan
Write-Host "Setting up AD DS Forest" -ForegroundColor Cyan

# Create variables for AD DS
$DomainName = "xyz.local"
$password = (ConvertTo-SecureString "Password1" -AsPlainText -Force)

# Import Active Directory
Import-Module ADDSDeployment | Out-Null

# Install AD DS Forest
Install-ADDSForest -DomainName $DomainName -SafeModeAdministratorPassword $password -InstallDNS:$true -Force:$true -WarningAction SilentlyContinue | Out-Null