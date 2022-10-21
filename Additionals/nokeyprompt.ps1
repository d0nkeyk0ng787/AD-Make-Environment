# Modify the ISO so it doesn't require a key prompt

. .\Additionals\New-IsoFile.ps1

function New-AutoISO{
    
    param(
    [Parameter(Mandatory = $true)][string[]]$ISO,
    [Parameter(Mandatory = $true)][string[]]$Type
    )

    # Auto ISO Path
    $AutoPath = "$ISOPath\AutoISO\"
    $SVRAutoISO = "$ISOPath\AutoISO\Server22-Auto.iso"
    $CLIAutoISO = "$ISOPath\AutoISO\Client10-Auto.iso"

    # Create AutoISO directory
    if(Test-Path -Path $AutoPath){
        Write-Host "Path already exists, continuing!" -ForegroundColor Cyan
    }
    else{
        New-Item -Type Directory -Path $AutoPath | Out-Null
    }

    # Create the server ISO
    if($Type -eq "Server"){
        if(Test-Path -Path $SVRAutoISO){
            Write-Host "Server Auto iso already exists...continuing!" -ForegroundColor Black -BackgroundColor Yellow
        }
        else{
            # Mount ISO
            Mount-DiskImage -ImagePath $ISO | Out-Null
            Write-Host "Server ISO image mounted" -ForegroundColor Cyan

            # Path to mounted ISO file
            $Drive = Get-DiskImage -ImagePath $ISO | Get-Volume | Select-Object DriveLetter
            $Drive = $Drive.DriveLetter + ":"

            # Create auto iso
            Write-Host "Creating Server Auto ISO..." -ForegroundColor Green
            $DrivePath = $Drive + "\"
            New-IsoFile -source $DrivePath -destinationiso $SVRAutoISO -bootfile "$Drive\efi\microsoft\boot\efisys_noprompt.bin" -title "Server22-Auto.iso" | Out-Null
            Write-Host "Server Auto ISO created" -ForegroundColor Cyan

            # Dismount the ISO
            Dismount-DiskImage -ImagePath $ISO | Out-Null
            Write-Host "Serevr ISO image dismounted" -ForegroundColor Cyan
        }
    }
    # Create the client ISO
    elseif($Type -eq "Client"){
        if(Test-Path -Path $CLIAutoISO){
            Write-Host "Client Auto iso already exists...continuing!" -ForegroundColor Black -BackgroundColor Yellow
        }
        else{
            # Mount ISO
            Mount-DiskImage -ImagePath $ISO | Out-Null
            Write-Host "Client ISO image mounted" -ForegroundColor Cyan

            # Path to mounted ISO file
            $Drive = Get-DiskImage -ImagePath $ISO | Get-Volume | Select-Object DriveLetter
            $Drive = $Drive.DriveLetter + ":"
            
            # Create auto iso
            Write-Host "Client Creating Auto ISO..." -ForegroundColor Green
            $DrivePath = $Drive + "\"
            New-IsoFile -source $DrivePath -destinationiso $CLIAutoISO -bootfile "$Drive\efi\microsoft\boot\efisys_noprompt.bin" -title "Client10-Auto.iso" | Out-Null
            Write-Host "Client Auto ISO created" -ForegroundColor Cyan

            # Dismount the ISO
            Dismount-DiskImage -ImagePath $ISO | Out-Null
            Write-Host "Client ISO image dismounted" -ForegroundColor Cyan
        }
    }
}
