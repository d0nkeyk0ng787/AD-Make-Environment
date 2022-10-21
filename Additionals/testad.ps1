# Test if AD has finished on the DC and it is ready to join the client systems

function Get-ADReady{
    param(
    [parameter(Mandatory=$true)][string[]]$VMName,
    [parameter(Mandatory=$true)]$Creds
    )

    Write-Host "Trying to retrieve the AD Object!..." -ForegroundColor Black -BackgroundColor Magenta
    while((Invoke-Command -VMName $DC1 -Credential $Creds -ScriptBlock{Get-ADObject -Filter * -ErrorAction SilentlyContinue}) -eq $null){Start-Sleep 5}
    Write-Host "AD object retrieved...Continuing!" -ForegroundColor Black -BackgroundColor Green

}