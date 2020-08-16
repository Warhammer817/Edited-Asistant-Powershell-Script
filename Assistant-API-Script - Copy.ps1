### Edit only this part! ################
$MyToken = ""
$ChatID = ""
#########################################

$InitialMessageDate = 0
$counter = 0

while ($true)
{
$MyBotUpdates = Invoke-WebRequest -Uri "https://api.telegram.org/bot$($MyToken)/getUpdates" -UseBasicParsing
#Convert the result from json and put them in an array
$jsonresult = [array]($MyBotUpdates | ConvertFrom-Json).Result

$LastMessage = ""

#write-host "before loop $InitialMessageDate"
Foreach ($Result in $jsonresult)  {
#write-host "$Result.update_id[-1]"
  If (($Result.channel_post.chat.id -eq $ChatID) -AND ($Result.update_id -gt $InitialMessageDate))  {
	if(($LastMessage -ne $null) -AND ($counter -gt 0)){
	powershell $Result.channel_post.text
	}
    $LastMessage = $Result.channel_post.text
  }
}
$InitialMessageDate = $jsonresult.update_id[-1]
sleep 1
$counter++
}