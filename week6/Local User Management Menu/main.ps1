. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt  = "Please choose your operation:`n"
$Prompt += "1  - List Enabled Users`n"
$Prompt += "2  - List Disabled Users`n"
$Prompt += "3  - Create a User`n"
$Prompt += "4  - Remove a User`n"
$Prompt += "5  - Enable a User`n"
$Prompt += "6  - Disable a User`n"
$Prompt += "7  - Get Log-In Logs`n"
$Prompt += "8  - Get Failed Log-In Logs`n"
$Prompt += "9  - List At-Risk Users`n"
$Prompt += "10 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"

        $created = checkUser $name
        if($created) {
            Write-Host "ERROR: This user already exists" | Out-String
            continue
        }

        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"

        $passValid = passCheck($password)

        if(-Not $passValid) {
            Write-Host "ERROR: Password does not meet the security conditions" | Out-String
            continue
        }

        createAUser $name $password

        Write-Host "User: $name is created." | Out-String
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        $created = checkUser $name
        if(-Not $created) {
            Write-Host "ERROR: This user does not exists" | Out-String
            continue
        }

        removeAUser $name

        Write-Host "User: $name Removed." | Out-String
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        $created = checkUser $name
        if(-Not $created) {
            Write-Host "ERROR: This user does not exists" | Out-String
            continue
        }

        enableAUser $name

        Write-Host "User: $name Enabled." | Out-String
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        $created = checkUser $name
        if(-Not $created) {
            Write-Host "ERROR: This user does not exists" | Out-String
            continue
        }

        disableAUser $name

        Write-Host "User: $name Disabled." | Out-String
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        $created = checkUser $name
        if(-Not $created) {
            Write-Host "ERROR: This user does not exists" | Out-String
            continue
        }

        $days = Read-Host -Prompt "Please enter the number of days to list"

        $userLogins = getLogInAndOffs $days


        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        $created = checkUser $name
        if(-Not $created) {
            Write-Host "ERROR: This user does not exists" | Out-String
            continue
        }

        $days = Read-Host -Prompt "Please enter the number of days to list"

        $userLogins = getFailedLogins $days

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    elseif($choice -eq 9){
        
        $riskLevel = 10

        $days = Read-Host -Prompt "Please enter the number of days to check"

        $userLogins = getRiskUsers $days $riskLevel

        Write-Host ($userLogins | Format-Table | Out-String )
    }


    else {
        Write-Host "Unrecognized input, please enter an available option." | Out-String
    }

}




