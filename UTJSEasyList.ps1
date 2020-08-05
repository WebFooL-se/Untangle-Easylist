##
## Script Create by WebFooL for The Untangle Community
##
$Request = Invoke-WebRequest "https://easylist.to/easylist/easylist.txt"
$EasyList = $Request.Content
$filename = "ADImport.json"

#CreateJsonFile
New-Item $filename
Set-Content $filename '[' -NoNewline


ForEach ($line in $($EasyList -split "`n"))
{
    #Remove all Commented lines (They all start with !)
    if($line -clike '!*') {
    #Do Nothing
    } elseif($line -eq "[Adblock Plus 2.0]"){
    #Do Nothing
    } elseif($line -clike '/\*'){
    #Do Nothing
    } elseif($line -clike '*\:*'){
    #Do Nothing
    } elseif($line -clike '*\5f*'){
    #Do Nothing
    } elseif($line -clike '*data-type=*'){
    #Do Nothing
    } elseif($line -clike '*title="ADVERTISEME*'){
    #Do Nothing
    } elseif($line -clike '*"googlead*'){
    #Do Nothing
    } elseif($line -clike '*"*'){
    #Do Nothing
    } elseif($line -eq ""){
    #Do Nothing
    }else {
        #Create Untangle JSON
        $newline = '{"string":"'+$line+'","blocked":true,"javaClass":"com.untangle.uvm.app.GenericRule","markedForNew":true,"markedForDelete":false,"enabled":true},'
        Add-Content $filename $newline -NoNewline
    }   
}

#Crap magic to To remove last ,
$file = Get-Content -Path $filename
foreach($line in $file) {
    Set-Content $filename $line.TrimEnd(",") -NoNewline
    }
#Add ending ]
Add-Content $filename ']' -NoNewline