. (Join-Path $PSScriptRoot Apache-Logs.ps1)
. (Join-Path $PSScriptRoot Apache-Parse.ps1)

clear
#Windows Apache Logs calls
$func1 = ApacheLogs 'page1.html' '200' 'chrome'
$counts = $func1 | Group-Object IP
$counts | Select-Object Count, Name

#Parsing Apache Logs calls
$tableRecords = ApacheLogs1
$tableRecords | Format-Table -AutoSize -Wrap