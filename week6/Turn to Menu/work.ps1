clear

#Q1
#Get-Process | Where-Object { $_.ProcessName -ilike 'C*' }

#Q2
#Get-Process | Where-Object { $_.Path -inotlike "*system32*" } | Select-Object ProcessName, Path

#Q3
#$folderpath = "C:\Users\Isaac\SYS320-01\outfolder"
#$filePath = Join-Path -Path $folderpath "stopped.csv"
#Get-Service | Where-Object { $_.Status -ilike "Stopped" } | Sort-Object |`
#Export-Csv -Path $filepath

#Q4 modified for Turn to menu assignment
function browser(){
    $chrome = Get-Process -Name "chrome" -ErrorAction SilentlyContinue
    $website = "https://www.champlain.edu"

    if ($chrome) {
        Write-Host "closing chrome"
        Stop-Process -Name "chrome"
    } else {
        Write-Host "opening chrome: routing to" $website
        Start-Process "chrome" -ArgumentList $website
    }
}