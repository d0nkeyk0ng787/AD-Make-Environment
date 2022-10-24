# Setup AD environment

# DNS

# Add a DNS forwarded
Set-DnsServerForwarder -IPAddress $using:DNSForwarder | Out-Null

# OUs

# Create your main OU
New-ADOrganizationalUnit -Name $using:BaseOU.Name -Path $using:BaseOU.Path 
# Devices
New-ADOrganizationalUnit -Name $using:Devices.Name -Path $using:Devices.Path
New-ADOrganizationalUnit -Name $using:Servers.Name -Path $using:Servers.Path
New-ADOrganizationalUnit -Name $using:Workstations.Name -Path $using:Workstations.Path
# Users
New-ADOrganizationalUnit -Name $using:Users.Name -Path $using:Users.Path
New-ADOrganizationalUnit -Name $using:Admins.Name -Path $using:Admins.Path
New-ADOrganizationalUnit -Name $using:Employees.Name -Path $using:Employees.Path
# Groups
New-ADOrganizationalUnit -Name $using:Groups.Name -Path $using:Groups.Path
New-ADOrganizationalUnit -Name $using:SecurityGroups.Name -Path $using:SecurityGroups.Path
New-ADOrganizationalUnit -Name $using:DistributionLists.Name -Path $using:DistributionLists.Path

# Completed message
Write-Host "XYZ OUs have been added...Continuing." -ForegroundColor Cyan

# Security Groups

# Create a new group for staff
$groupparams = @{
    Name = "Staff"
    SamAccountName = "Staff"
    GroupCategory = "Security"
    GroupScope = "Global"
    DisplayName = "Staff"
    Path = "OU=SecurityGroups,OU=Groups,OU=XYZ,DC=xyz,DC=local"
    Description = "Members of this group are staff at XYZ"
}
New-ADGroup @groupparams

# Completed message
Write-Host "Staff group created...Continuing" -ForegroundColor Cyan

# Users

# NOTE - This will create a single user, for more users, copy the config.csv and makeusers.ps1 files to the vm
# where the config.csv is filled out with the requried information.
# Create the user
$Params = @{
    Name = "john.smith"
    GivenName = "John"
    Surname = "Smith"
    DisplayName = "Smith, John"
    Path = "OU=Employees,OU=Users,OU=XYZ,DC=xyz,DC=local"
    AccountPassword = $using:Password
    Enabled = $true
    ChangePasswordAtLogon = $true
}
New-ADUser @params

# Add user to staff group
Add-AdGroupMember -Identity "Staff" -Members "john.smith"

# Add user to remote desktop users
Add-ADGroupMember -Identity "Remote Desktop Users" -Members "john.smith"

# Print message if User was created
Write-Host "A user with the name John Smith was created." -ForegroundColor Cyan
Write-Host "John Smith was added to the Staff group" -ForegroundColor Cyan
Write-Host "John Smith was added to the remote desktop users group" -ForegroundColor Cyan