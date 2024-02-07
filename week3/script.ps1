clear

function LoginoutLog {
    param ([int]$days)

    $loginouts = Get-EventLog System -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$days)

    $loginoutsTable = @() 
    for ($i=0;$i -lt $loginouts.Count; $i++) {
        $event = ""
        if ($loginouts[$i].InstanceId -eq 7001) {$event="Logon"}
        if ($loginouts[$i].InstanceId -eq 7002) {$event="Logoff"}

        $idString = $loginouts[$i].ReplacementStrings[1]

        $id = New-Object System.Security.Principal.SecurityIdentifier($idString)

        try {
            # Translating the SID to a username
            $user = $id.Translate([System.Security.Principal.NTAccount]).Value
        } catch {
            $user = "Unable to translate"
        }

        $loginoutsTable += [pscustomobject]@{
            "Time" = $loginouts[$i].TimeGenerated
            "Id" = $loginouts[$i].EventID
            "Event" = $event;
            "User" = $user;
        }
    }

    return $loginoutsTable
}

function ShutdownLog {
    param ([int]$days)

    $loginouts = Get-EventLog System -After (Get-Date).AddDays(-$days)| Where-Object { $_.EventID -eq 6006 -or $_.EventID -eq 6005 }

    $loginoutsTable = @() 
    for ($i=0;$i -lt $loginouts.Count; $i++) {
        $event = ""
        if ($loginouts[$i].EventID -eq 6006) {$event="Shutdown"}
        if ($loginouts[$i].EventID -eq 6005) {$event="Startup"}

        $idString = $loginouts[$i].ReplacementStrings[1]

        $user = "System"

        $loginoutsTable += [pscustomobject]@{
            "Time" = $loginouts[$i].TimeGenerated
            "Id" = $loginouts[$i].EventID
            "Event" = $event;
            "User" = $user;
        }
    }

    return $loginoutsTable
}