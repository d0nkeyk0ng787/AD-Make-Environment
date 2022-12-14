# Test if AD has finished on the DC and it is ready to join the client systems

$chars = "/", "-", "\", "|"
$state = 1
$counter = 0
$mult = 1

function Get-ADReady{
    param(
    [parameter(Mandatory=$true)][string[]]$VMName,
    [parameter(Mandatory=$true)]$Creds
    )
    Write-Host "Trying to retrieve the AD Object!..." -ForegroundColor Green -BackgroundColor Black
    Start-Job -Name "getADObject" -ScriptBlock {while((Invoke-Command -VMName $using:VMName -Credential $using:Creds -ScriptBlock{Get-ADObject -Filter * -ErrorAction SilentlyContinue}) -eq $null){Start-Sleep 5}} | Out-Null

    for ($i=0;$i -le 5; $i++) {
        if((Get-Job -Name getADObject).State -eq  "Completed"){
            Write-Host "`r`nAD object retrieved...Continuing!" -ForegroundColor Black -BackgroundColor Magenta
            break
        }
        else{
            if($i -eq 4){
                $i = 0
            }
            if($script:counter -eq 10){
                $script:counter = 0
                $script:mult++
            }
            $progress = $chars[$i] * $mult
            Write-Host -NoNewLine "`r$progress" -ForegroundColor Green -BackgroundColor Black
            $script:counter++
            Start-Sleep -Milliseconds 150
        }
    }
}