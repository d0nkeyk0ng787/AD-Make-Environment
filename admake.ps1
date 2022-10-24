# Script to control the execution of the AD environment creation scripts
# Created 03 OCT 22 | Gnome787

# Imports
. .\config.ps1
. .\Additionals\New-IsoFile.ps1
. .\Additionals\nokeyprompt.ps1
. .\Additionals\testconnectivity.ps1
. .\Additionals\testad.ps1
. .\Additionals\pressanykey.ps1
. .\Additionals\addautounattend.ps1
. .\Additionals\getadobject.ps1

<#
###################################################
####Create AutoISO, Make VMs and Unattend files####
###################################################
#>
# Create auto ISO
New-AutoISO -ISO $ServerISO -Type "Server"
New-AutoISO -ISO $ClientISO -Type "Client"
# Run the script that makes the VMs
powershell .\1VMs\makevms.ps1
# Sleep until the VMs are created
Start-Sleep -Seconds 10

<#
###################################################
###############Create and setup DC1################                      
###################################################
#>
# Start the DC
Write-Host "$DC1 is running" -ForegroundColor Black -BackgroundColor Green
# Continue when Windows install has completed
Write-Host "Windows is being installed!" -ForegroundColor Black -BackgroundColor Magenta
Wait-ForPS -VMName $DC1 -Creds $Cred
Write-Host "`r`nPre AD setup is beginning" -ForegroundColor Cyan
# Perform pre AD config
Invoke-Command -VMName $DC1 -FilePath .\2DC1\pread.ps1 -Credential $Cred
Write-Host "Finished installing AD DS Forest" -ForegroundColor Black -BackgroundColor Yellow
# Install-ADDSForest
# Sleep until the DC responds to PS remoting
Wait-ForPS -VMName $DC1 -Creds $DomainCred
#Test-Connectivity -VMName DC1 -Creds $DomainCred
Start-Sleep -Seconds 60
#Get-ADReady -VMName $DC1 -Creds $DomainCred
Get-ADReady -VMName $DC1 -Creds $DomainCred
Start-Sleep 5
Remove-Job -Name "getADObject"
# Setup the AD environment
# Make OUs, security groups, and add users
Invoke-Command -VMName $DC1 -FilePath .\2DC1\adenv.ps1 -Credential $DomainCred

<#
###################################################
###############Create and setup DHCP###############                    
###################################################
#>
Write-Host "Moving on to DHCP setup" -ForegroundColor Cyan
# Setup the DHCP server
Write-Host "$DHCP server is running" -ForegroundColor Black -BackgroundColor Green
# Continue when Windows install has completed
Write-Host "Windows is being installed!" -ForegroundColor Black -BackgroundColor Magenta
Wait-ForPS -VMName $DHCP -Creds $Cred
Write-Host "`r`n$DHCP setup is beginning" -ForegroundColor Cyan
# Perform DHCP server setup
Invoke-Command -VMName $DHCP -FilePath .\3DHCP\installdhcp.ps1 -Credential $Cred
Start-Sleep -Seconds 10
# Setup the DHCP server, add security groups, add server as an authorised DHCP server, create and setup scopes
Invoke-Command -VMName $DHCP -FilePath .\3DHCP\setupdhcp.ps1 -Credential $DomainCred
Write-Host "Finished setting up $DHCP" -ForegroundColor Black -BackgroundColor Yellow

<#
###################################################
##############Create and setup FSVR1###############                    
###################################################
#>
Write-Host "Moving on to FSVR setup" -ForegroundColor Cyan
# Setup the File Server
Write-Host "$FSVR1 is running" -ForegroundColor Black -BackgroundColor Green
# Continue when Windows install has completed
Write-Host "Windows is being installed!" -ForegroundColor Black -BackgroundColor Magenta
Wait-ForPS -VMName $FSVR1 -Creds $Cred
Write-Host "`r`n$FSVR1 setup is beginning" -ForegroundColor Cyan
# Perform FSVR1 setup
Invoke-Command -VMName $FSVR1 -FilePath .\4FSVR1\installfsvr1.ps1 -Credential $Cred
# Sleep until server restarts
Start-Sleep -Seconds 10
# Setup the FSVR1, create disk, create smb share, setup dfs, drive mapping
Invoke-Command -VMName $FSVR1 -FilePath .\4FSVR1\setupfsvr1.ps1 -Credential $DomainCred
Write-Host "Finished setting up $FSVR1" -ForegroundColor Black -BackgroundColor Yellow
# Create drive mapping GPO on DC1
Write-Host "Implement GPO on $DC1 to map the users home drive" -ForegroundColor Cyan
# Implement GPO
Invoke-Command -VMName $DC1 -FilePath .\4FSVR1\drivegpo.ps1 -Credential $DomainCred
Write-Host "GPO implemented" -ForegroundColor Black -BackgroundColor Yellow

<#
###################################################
##############Create and setup CLI1################                    
###################################################
#>
Write-Host "Moving on to $CLI1" -ForegroundColor Cyan
# Setup the Client
Write-Host "$CLI1 is running" -ForegroundColor Black -BackgroundColor Green
# Continue when Windows install has completed
Write-Host "Windows is being installed!" -ForegroundColor Black -BackgroundColor Magenta
Wait-ForPS -VMName $CLI1 -Creds $Cred
Write-Host "`r`n$CLI1 setup is beginning" -ForegroundColor Cyan
Start-Sleep -Seconds 10
# Perform CLI1 setup. Create a PSSession and store it in a variable to get past Access is denied error with Invoke-Command
$Session = New-PSSession -VMName $CLI1 -Credential $Cred
Invoke-Command -Session $Session -FilePath .\5CLI1\installcli.ps1
Start-Sleep -Seconds 20
Write-Host "$CLI1 setup complete" -ForegroundColor Cyan
Write-Host "AD environment setup complete...Exiting!" -ForegroundColor Black -BackgroundColor Green
