clear

#Q3
#Get-Content C:\xampp\apache\logs\access.log

#Q4
#Get-Content C:\xampp\apache\logs\access.log -Tail 5

#Q5
#Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ', ' 400 '

#Q6
#Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 ' -NotMatch

#Q7
#$A = Get-ChildItem -Path C:\xampp\apache\logs\*.log | Select-String 'error'
#$A[0..-4]

#Q8
#$notfounds = Get-Content -Path C:\xampp\apache\logs\access.log | Select-String ' 404 '
    
#$regex = [regex] "\b(?:\d{1,3}\.){3}\d{1,3}\b"

#$ipsUnorganized = $regex.Matches($notfounds)

#$ips = @()
#for ($i=0; $i -lt $ipsUnorganized.Count; $i++) {
#    $ips += [PSCustomObject]@{ "IP" = $ipsUnorganized[$i].value; }
#}
#$ips | Where-Object { $_.IP -ilike "192.*" }

#Q9
#$ipsoftens = $ips | Where-Object { $_.IP -ilike "*" }
#$counts = $ipsoftens | Group-Object IP
#$counts | Select-Object Count, Name