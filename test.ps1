$Contin = Read-Host -Prompt "Would you like to continue with installing additional features of AD? (Y/N)"
$Contin = $Contin.ToLower()

# Create extra variable
$Extra = 0

function Get-Continue {
    # See if user wants to continue
    if ($Contin -eq "n"){
        Write-Host "AD environment setup complete. Exiting..." -ForegroundColor Green
        $ExitState = 1
    }
    else{
        Write-Host "Extras include: add additional users, add an additional machine, setup wallpaper GPO." -ForegroundColor Cyan
        $Extra = Read-Host -Prompt "Select 1, 2 or 3 respectively to make a choice, alternatively press 4 to exit"
    }

    # Continue with extra installs
    if ($Extra -eq "1"){
        Add-Users
    }
    ElseIf ($Extra -eq "2"){
        Add-Machine -VMName "SVR1"
    }
    ElseIF ($Extra -eq "3"){
        Write-Host "To be configured" -ForegroundColor Red
    }
    Elseif ($Extra -eq "4"){
        Write-Host "AD environment setup complete. Exiting..." -ForegroundColor Green
        break
    }
}

$ExitState = 0

While ($ExitState -eq 0){
    Get-Continue
}