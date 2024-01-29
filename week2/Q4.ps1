clear

#Q4
$chrome = Get-Process -Name "chrome" -ErrorAction SilentlyContinue
$website = "https://www.champlain.edu"

if ($chrome) {
    Write-Host "closing chrome"
    Stop-Process -Name "chrome"
} else {
    Write-Host "opening chrome: routing to" $website
    Start-Process "chrome" -ArgumentList $website
}