# Waiting animation script
# Written by Gnome787

$chars = "/", "-", "\", "|"
$state = 1
$counter = 0
$mult = 1

function Invoke-Loading{
    for ($i=0;$i -le 5; $i++) {
        if($i -eq 4){
        $i = 0
        }
        if($script:counter -eq 20){
        $script:counter = 0
        $script:mult++
        }
        $progress = $chars[$i] * $mult
        Write-Host -NoNewLine "`r$progress" -ForegroundColor Green -BackgroundColor Black
        $script:counter++
        Start-Sleep -Milliseconds 150
    }
}
