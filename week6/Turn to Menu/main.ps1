. (Join-Path $PSScriptRoot Apache-Parse.ps1)
. (Join-Path $PSScriptRoot work.ps1)
. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt  = "Please choose your operation:`n"
$Prompt += "1  - List last 10 apache logs`n"
$Prompt += "2  - List last 10 failed logins`n"
$Prompt += "3  - List at risk users`n"
$Prompt += "4  - Launch champlain.edu`n"
$Prompt += "5  - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1) {
        $tableRecords = ApacheLogs1
        $tableRecords | Select-Object -Last 10 | Format-Table -AutoSize -Wrap 
    
    }


    elseif($choice -eq 2){

        $userLogins = getFailedLogins 365

        Write-Host ($userLogins | Select-Object -Last 10 | Format-Table | Out-String)
    }


    elseif($choice -eq 3){
        
        $riskLevel = 10

        $days = Read-Host -Prompt "Please enter the number of days to check"

        $userLogins = getRiskUsers $days $riskLevel

        Write-Host ($userLogins | Format-Table | Out-String )
    }


    elseif($choice -eq 4){

        browser
    }


    else {
        Write-Host "Unrecognized input, please enter an available option." | Out-String
    }

}




