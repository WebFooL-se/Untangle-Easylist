##
## Script Create by WebFooL for The Untangle Community
##
$Request = Invoke-WebRequest "https://easylist.to/easylist/easylist.txt"
$EasyList = $Request.Content
$filenamejson = "ADImport.json"
$filenamecsv = "ADImport.csv"
$hash = $null

$hash = @'
string,blocked,javaClass,markedForNew,markedForDelete,enabled

'@

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
import-csv $filenamecsv | ConvertTo-Json | Set-Content -Path $filenamejson
#Done
