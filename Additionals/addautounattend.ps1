# Create the autounattend iso

. .\Additionals\New-IsoFile.ps1
. .\config.ps1

function New-UnattendISO{
    
    param(
    [Parameter(Mandatory = $true)][string[]]$VMName,
    [Parameter(Mandatory = $true)][string[]]$VMType
    )
    
    # Variables
    $Unattendxml = "$Installdir\Autounattend\$VMType\autounattend.xml"
    $Unattendxml = "$Installdir\Autounattend\$VMType\autounattend.xml"
    $Unattendiso = $VMLocation+"\"+$VMName+"\autounattend.iso"
    $VMPath = $VMLocation+"\"+$VMName
    $UnattendPath = $VMPath+"\Autounattend\autounattend.xml"

    Write-Host "Creating autounattend iso for $VMName" -ForegroundColor Cyan

    # Copy autounattend to VM folder
    New-Item -ItemType Directory "$VMPath\Autounattend\" | Out-Null
    Copy-Item -Path $Unattendxml -Destination "$VMPath\Autounattend\autounattend.xml"

    # Change computer name in the unattend file for each vm
    (Get-Content $UnattendPath).replace("SetNameHere", $VMName) | Set-Content $UnattendPath | Out-Null

    New-IsoFile -source $UnattendPath -destination $Unattendiso | Out-Null
    Add-VMDvdDrive -VMName $VMName -Path $Unattendiso
    Write-Host "Autounattend iso file added to $VMName" -ForegroundColor Cyan

    # Remove unattend folder
    Remove-Item -Path "$VMPath\Autounattend\" -Recurse
    Write-Host "Autounattend cleanup for $VMName completed" -ForegroundColor Cyan
}