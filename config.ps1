<# 
Configuration file for AD-Make-Environment

The variables in this file are the only ones you need to modify
for this program to work. 
#>

# Install paths
$Installdir = Get-Location
$VMLocation = "H:\VMs"
$ISOPath = "H:\ISO"
$ServerISO = "$ISOPath\SERVER_EVAL_x64FRE_en-us.iso"
$ClientISO = "$ISOPath\Windows.iso"

# Virtual Machines
$DC1 = "DC1"
$DHCP = "DHCP"
$FSVR1 = "FSVR1"
$SVR1 = "SVR1"
$CLI1 = "CLI1"

# Credential objects
# Standard Administrator credential object
$Password = ConvertTo-SecureString "Password1" -AsPlainText -Force
$Cred = New-Object System.Management.Automation.PSCredential ("Administrator", $Password) 
# Domain Administrator credential object
$Password = ConvertTo-SecureString "Password1" -AsPlainText -Force
$DomainCred = New-Object System.Management.Automation.PSCredential ("xyz\Administrator", $Password) 

# Domain informaton
$Domain = "xyz.local"
$DomainName = "xyz"
