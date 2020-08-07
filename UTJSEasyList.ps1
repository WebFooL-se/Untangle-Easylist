##
## Script Create by WebFooL for The Untangle Community
##
$easylistsource = "https://easylist.to/easylist/easylist.txt"
$Request = Invoke-WebRequest $easylistsource
$EasyList = $Request.Content
$filenamejson = "ADImport.json"
$filenamecsv = "ADImport.csv"
$hash = $null

$hash = @'
string,blocked,javaClass,markedForNew,markedForDelete,enabled

'@

write-host "Will now work for a whule do not panic!"

ForEach ($line in $($EasyList -split "`n"))
{
    #Remove all Commented lines (They all start with !)
    if($line -clike '!*') {
    #Do Nothing
    } elseif($line -eq "[Adblock Plus 2.0]"){
    #Do Nothing
    }elseif($line -eq ""){
    #Do Nothing
    }else {
        #Create Untangle JSON
        $hash += "$line,true,com.untangle.uvm.app.GenericRule,true,false,true`r`n"
    }   
}
#Tempstore as CSV
$hash | Set-Content -Path $filenamecsv
#Convert to Json
import-csv $filenamecsv | ConvertTo-Json -Compress | Set-Content -Path $filenamejson
#Count lines in the CSV
$numberoflines = (Import-Csv $filenamecsv | Measure-Object -Property string).Count
#Write friendly exit message
Write-Host "Done you now have a $filenamejson with $numberoflines lines from $easylistsource"
