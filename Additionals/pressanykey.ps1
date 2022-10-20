# Press any key function
function Press-Any {

    param (
        [string[]]$CustomMessage
    )

    Write-Host -NoNewLine $CustomMessage 'Press any key to continue...' -ForegroundColor Magenta -BackgroundColor Black
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
}