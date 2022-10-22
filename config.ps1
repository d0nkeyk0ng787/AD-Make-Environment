<# 
Configuration file for AD-Make-Environment

The variables in this file are the only ones you need to modify
for this program to work. 
#>

# Install paths
$Installdir = Get-Location
$VMLocation = "E:\VMs"
$ISOPath = "E:\MakeADEnv\ISO"
$ServerISO = "$ISOPath\SERVER_EVAL_x64FRE_en-us.iso"
$ClientISO = "$ISOPath\Windows.iso"

# Adapter Name
$AdapterName = "Default Switch"

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
$DomainName = "xyz.local"
$NetBIOSName = "xyz"
$TLD = "local"

# IP addressing
$IntName = "Ethernet"
$Gateway = "192.168.100.1"
$DC1IP = "192.168.100.2"
$DHCPIP = "192.168.100.3"
$FSVR1IP = "192.168.100.5"
$Prefix = "24"
$DNSForwarder = "1.1.1.1"

# DHCP Configuration
$ScopeName = "Internal"
$Net = "192.168.100.0"
$Start = "192.168.100.50"
$End = "192.168.100.254"
$Sub = "255.255.255.0"
$ExcludeStart = "192.168.100.1"
$ExcludeEnd = "192.168.100.49"
$DHCPHostname = "dhcp.xyz.local"

# OUs - For additional OUs, simply replicate an exisitng PSCustomObject on a new line and adjust as needed
$BaseOU = [PSCustomObject]@{Name = "XYZ"; Path = "DC=xyz,DC=local"}
$Devices = [PSCustomObject]@{Name = "Devices"; Path = "OU=XYZ,DC=xyz,DC=local"}
$Servers = [PSCustomObject]@{Name = "Servers"; Path = "OU=Devices,OU=XYZ,DC=xyz,DC=local"}
$Workstations = [PSCustomObject]@{Name = "Workstations"; Path = "OU=Devices,OU=XYZ,DC=xyz,DC=local"}
$Users = [PSCustomObject]@{Name = "Users"; Path = "OU=XYZ,DC=xyz,DC=local"}
$Admins = [PSCustomObject]@{Name = "Admins"; Path = "OU=Users,OU=XYZ,DC=xyz,DC=local"}
$Employees = [PSCustomObject]@{Name = "Employees"; Path = "OU=Users,OU=XYZ,DC=xyz,DC=local"}
$Groups = [PSCustomObject]@{Name = "Groups"; Path = "OU=XYZ,DC=xyz,DC=local"}
$SecurityGroups = [PSCustomObject]@{Name = "SecurityGroups"; Path = "OU=Groups,OU=XYZ,DC=xyz,DC=local"}
$DistributionLists = [PSCustomObject]@{Name = "DistributionLists"; Path = "OU=Groups,OU=XYZ,DC=xyz,DC=local"}
