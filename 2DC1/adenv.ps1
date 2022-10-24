# Setup AD environment

# DNS

# Add a DNS forwarded
Set-DnsServerForwarder -IPAddress $using:DNSForwarder | Out-Null

# Create OU
foreach($OU in $using:OUs){
    New-ADOrganizationalUnit -Name $OU.Name -Path $OU.Path
}

# Completed message
Write-Host "$using:NetBIOSName OUs have been added...Continuing." -ForegroundColor Cyan

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