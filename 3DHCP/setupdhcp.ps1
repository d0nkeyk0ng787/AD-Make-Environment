# Setup DHCP environment

# Install DHCP
Install-WindowsFeature DHCP -IncludeManagementTools | Out-Null

# Add DHCP security groups
netsh dhcp add securitygroups | Out-Null

# Restart DHCP server
Restart-Service dhcpserver | Out-Null

Write-Host "DHCP security groups added" -ForegroundColor Cyan
Write-Host "DHCP service is restarting..." -ForegroundColor Black -BackgroundColor Magenta

# Sleep for a few seconds
Start-Sleep -Seconds 5

# Add the DHCP server to the list of authorised DHCP servers in AD
Add-DhcpServerInDC -Dnsname $using:DHCPHostname | Out-Null

Write-Host "DHCP server has been authorised in the DC" -ForegroundColor Cyan

# Notify the server that post install is complete
Set-ItemProperty –Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\Roles\12 –Name ConfigurationState –Value 2 | Out-Null

# Create internal scope
Add-DhcpServerv4Scope -Name $using:ScopeName -StartRange $using:Start -EndRange $using:End -SubnetMask $using:Sub -Description "Internal Network"

# Globally define the DNSServer IP, Domain and the default router.
Set-DhcpServerv4OptionValue -DNSServer $using:DC1IP -DNSDomain $using:DomainName -Router $using:Gateway

# Create an Exclusion range on the scope
Add-Dhcpserverv4ExclusionRange -ScopeId $using:Net -StartRange $using:ExcludeStart -EndRange $using:ExcludeEnd

# Complete message
Write-Host "Internal scope configured." -ForegroundColor Cyan
Write-Host "DHCP server setup is complete...continuing" -ForegroundColor Cyan