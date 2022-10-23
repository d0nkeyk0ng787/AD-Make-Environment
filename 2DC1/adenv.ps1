# Setup AD environment

# DNS

# Add a DNS forwarded
Set-DnsServerForwarder -IPAddress $using:DNSForwarder | Out-Null

# OUs

# Create your main OU
New-ADOrganizationalUnit -Name $BaseOU.Name -Path $BaseOU.Path 
# Devices
New-ADOrganizationalUnit -Name $Devices.Name -Path $Devices.Path
New-ADOrganizationalUnit -Name $Servers.Name -Path $Servers.Path
New-ADOrganizationalUnit -Name $Workstations.Name -Path $Workstations.Path
# Users
New-ADOrganizationalUnit -Name $Users.Name -Path $Users.Path
New-ADOrganizationalUnit -Name $Admins.Name -Path $Admins.Path
New-ADOrganizationalUnit -Name $Employees.Name -Path $Employees.Path
# Groups
New-ADOrganizationalUnit -Name $Groups.Name -Path $Groups.Path
New-ADOrganizationalUnit -Name $SecurityGroups.Name -Path $SecurityGroups.Path
New-ADOrganizationalUnit -Name $DistributionLists.Name -Path $DistributionLists.Path

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