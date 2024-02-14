function ApacheLogs1 () {
    $logsNotFormatted = Get-Content C:\xampp\apache\logs\access.log
    $tableRecords = @()

    for ($i = 0; $i -lt $($logsNotFormatted.count); $i++) {
        $words = $logsNotFormatted[$i].Split(" ")
        
        #I'm pretty sure the $tableRecords shown on the assignment page is
        #misslabeled but I tried to copy it anyways. I reoganized the trims properly though
        $tableRecords += [pscustomobject]@{ "IP" = $words[0];
                                            "Time" = $words[3];
                                            "Method" = $words[4].Trim(']');
                                            "Page" = $words[5].Trim('"');
                                            "Protocol" = $words[6];
                                            "Response" = $words[7];
                                            "Referrer" = $words[10];
                                            "Client" = $words[13..($words.LongLength)];}
                                            #I have no clue what client is supposed to be, [11] shows nothing
                                            #and there is no visible expected output on the assignment page

    }
    return $tableRecords | Where-Object {$_.IP -ilike "192.*" }
}
