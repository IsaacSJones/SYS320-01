clear
function gatherClasses() {
    $page = Invoke-WebRequest -TimeoutSec 2 http://192.168.56.1/Courses.html

    $trs = $page.ParsedHtml.body.getElementsByTagName("tr")

    $FullTable = @()
    for($i=1; $i -lt $trs.length; $i++) {
        $tds = $trs[$i].getElementsByTagName("td")

        $Times = $tds[5].innerText.split("-")

        $FullTable += [pscustomobject]@{"Class Code" = $tds[0].innerText;
                                        "Title"      = $tds[1].innerText;
                                        "Days"       = $tds[4].innerText;
                                        "Time Start" = $Times[0];
                                        "Time End"   = $Times[1];
                                        "Instructor" = $tds[6].innertext;
                                        "Location"   = $tds[9].innertext;
        }
    }
    return $FullTable
}

function daysTranslator($FullTable) {
    for($i=0; $i -lt $FullTable.length; $i++) {
        $Days = @()

        if($FullTable[$i].Days -ilike "M*"){ $Days += "Monday"}

        if($FullTable[$i].Days -ilike "*T[TWF]*"){ $Days += "Tuesday"}

        if($FullTable[$i].Days -ilike "*W*"){ $Days += "Wednesday"}

        if($FullTable[$i].Days -ilike "*TH*"){ $Days += "Thursday"}

        if($FullTable[$i].Days -ilike "*F*"){ $Days += "Friday"}

        $FullTable[$i].Days = $Days
    }
    return $FullTable
}

$FullTable = daysTranslator(gatherClasses)

#i
#$FullTable | select "Class Code", Instructor, Location, Days, "Time Start", "Time End" | 
#             where {$_."Instructor" -ilike "*Furkan Paligu"}

#ii
#$FullTable | Where-Object { ($_.Location -ilike "JOYC 310") -and ($_.days -ccontains "Monday") } |
#             sort "Time Start" |
#             select "Time Start", "Time End", "Class Code"

#iii
$ITSInstructors = $FullTable | where-object { ($_."Class Code" -ilike "SYS*") -or `
                                              ($_."Class Code" -ilike "NET*") -or `
                                              ($_."Class Code" -ilike "SEC*") -or `
                                              ($_."Class Code" -ilike "FOR*") -or `
                                              ($_."Class Code" -ilike "CSI*") -or `
                                              ($_."Class Code" -ilike "DAT*") } `
                             | Sort-Object "Instructor" `
                             | select "Instructor" -Unique

$FullTable | where { $_.Instructor -in $ITSInstructors.Instructor } `
           | Group-Object "Instructor" | select Count, Name | Sort-Object Count -Descending