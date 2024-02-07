. (Join-Path $PSScriptRoot script.ps1)

clear

$loginoutsTable = LoginoutLog -days 60
$loginoutsTable

$shutandstartTable = ShutdownLog -days 60
$shutandstartTable