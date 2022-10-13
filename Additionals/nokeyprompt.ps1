# Modify the ISO so it doesn't require a key prompt

Import-Module H:\MakeADEnv\Additionals\New-IsoFile.ps1

# Mount ISO
Mount-DiskImage -ImagePath H:\ISO\SERVER_EVAL_x64FRE_en-us.iso | Out-Null

Write-Host "ISO image mounted" -ForegroundColor Cyan

# Path to mounted ISO file
$Drive = Get-DiskImage -ImagePath H:\ISO\SERVER_EVAL_x64FRE_en-us.iso | Get-Volume | Select-Object DriveLetter
$Drive = $Drive.DriveLetter + ":"

# ISO Path
$ISO = "H:\ISO\SERVER_EVAL_x64FRE_en-us.iso"
# Auto ISO Path
$AutoISO = "H:\ISO\AutoISO\Server22-Auto.iso"

# Create directory for new ISO
$AutoPath = "H:\ISO\AutoISO"
if(Test-Path -Path $AutoPath){
    Write-Host "Auto iso already exists...continuing!" -ForegroundColor Black -BackgroundColor Yellow
}
else{
    Write-Host "Creating Auto ISO..." -ForegroundColor Green
    New-Item -Type Directory -Path $AutoPath | Out-Null

    # Create auto iso
    $DrivePath = $Drive + "\"
    New-IsoFile -source $DrivePath -destinationiso $AutoISO -bootfile "$Drive\efi\microsoft\boot\efisys_noprompt.bin" -title "Server22-Auto.iso" | Out-Null

    Write-Host "Auto ISO created" -ForegroundColor Cyan
}

# Dismount the ISO
Dismount-DiskImage -ImagePath H:\ISO\SERVER_EVAL_x64FRE_en-us.iso | Out-Null

Write-Host "ISO image dismounted" -ForegroundColor Cyan