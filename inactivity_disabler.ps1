#credits: Sam Rosenblum of OSibeyond, who wrote the base of this

#periodically run this on every domain controller whenever an incident occurs to disable all AD accounts that are older than 90 days old without a static passwd

#powershell script to disable all accounts that are older than 90 days inactive and 
# also do not have static passwords
#OU and DC values need to be changed, please do so during init.

<# 
$oudc = "OU=$OU1,OU=$OU2,OU=$OU3,DC=$DC1,DC=$DC3"
$OU1 = EXOS
$OU2 = LeadingAge Users
$OU3 = LeadingAge
$DC1 = LeadingAge
$DC2 = local
#>

$oudc = (Read-Host "Please enter OUs and DCs in the following format: 'OU=EXOS,OU=LeadingAge Users,OU=LeadingAge,DC=LeadingAge,DC=local' ")
#example $oudc for LeadingAge= "OU=EXOS,OU=LeadingAge Users,OU=LeadingAge,DC=LeadingAge,DC=local"

#script
$timespan = New-Timespan -Days 90
Search-ADAccount -UsersOnly -AccountInactive -TimeSpan $timespan -SearchBase $oudc |where {$_.enabled} |where #{$_.PasswordNeverExpires -eq $False} |Disable-ADAccount


