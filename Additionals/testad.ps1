# Test if AD has finished on the DC and it is ready to join the client systems

. H:\MakeADEnv\config.ps1

function Get-ADReady{
    param(
    [parameter(Mandatory=$true)][string[]]$VMName,
    [parameter(Mandatory=$true)]$Creds
    )

    Write-Host "Trying to retrieve the AD Object!..." -ForegroundColor Black -BackgroundColor Magenta
    $ADObj = Invoke-Command -VMName $DC1 -Credential $DomainCred -ScriptBlock{(Get-ADObject -Filter 'Name -like "xyz"').Name}
    while($ADObj -ne "$DomainName"){Start-Sleep 2}
    Write-Host "AD object retrieved...Continuing!" -ForegroundColor Black -BackgroundColor Green

}