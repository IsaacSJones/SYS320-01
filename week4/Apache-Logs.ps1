function ApacheLogs {
    param ([string]$page, [string]$http, [string]$browser)

    $results = Get-Content -Path C:\xampp\apache\logs\access.log | Select-String $page | Select-String $http | Select-String $browser
    
    $regex = [regex] "\b(?:\d{1,3}\.){3}\d{1,3}\b"

    $ipsUnorganized = $regex.Matches($results)

    $ips = @()
    for ($i=0; $i -lt $ipsUnorganized.Count; $i++) {
        $ips += [PSCustomObject]@{ "IP" = $ipsUnorganized[$i].value; }
    }

    #opened up to all IPs just to show the rest of the code works
    $ipsoftens = $ips | Where-Object { $_.IP -ilike "*" }
    return $ipsoftens
}

