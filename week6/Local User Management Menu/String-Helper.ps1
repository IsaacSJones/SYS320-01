<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}

function passCheck($password) {
    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
    $password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)

    $hasSpecialCharacter = '[\W_]'
    $hasNumber = '\d'
    $hasLetter = '[a-zA-Z]'

    if ($password.Length -lt 6) {
        return $false
    }

    if ($password -notmatch $hasSpecialCharacter -or $password -notmatch `
        $hasNumber -or $password -notmatch $hasLetter) {
        return $false
    }

    return $true

}