# Test VM connectivity

# Wait for PS Remoting
function Wait-ForPS {

    param (
        [Parameter(Mandatory = $true)] [string[]]$VMName,
        [Parameter(Mandatory = $true)] $Creds
    )

    Write-Host "Waiting for" $VMName "to respond to PS remoting" -ForegroundColor Cyan
    while ((icm -VMName $VMName -Credential $Creds {"Test"} -ea SilentlyContinue) -ne "Test") {Sleep -Seconds 1}
    Write-Host $VMName "is responding to PS remoting...Continuing" -ForegroundColor Cyan 
}

# Test if LogonUI is still up
function Test-Connectivity{

    param(
    [parameter(Mandatory = $true)][string[]]$VMName,
    [parameter(Mandatory = $true)]$Creds
    )

    Write-Host "Waiting on LogonUI..." -ForegroundColor Black -BackgroundColor Magenta
    while((Invoke-Command -VMName $VMName -Credential $Creds -ScriptBlock {Get-Process "LogonUI" -ea SilentlyContinue}) -ne $null){Start-Sleep 2}
    Write-Host "LogonUI is down...Continuing!" -ForegroundColor Black -BackgroundColor Green
}
