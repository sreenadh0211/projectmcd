$Scount= ${env:SwitchCount}
write-host $Scount
$Vpath= ${env:VmFolderPath}
write-host $Vpath

$json = Get-Content '.\vmdata.json' | Out-String | ConvertFrom-Json
$json | Out-String | ConvertTo-json
$fname= $Vpath
$vmcount = (Get-ChildItem -Path $fname -Name).count
$vhds = Get-ChildItem -Path $fname -Name
$vmcount = $vmcount.ToString()
$Scount = $Scount.ToString()
$json | Add-Member -Type NoteProperty -Name "VMCount" -Value $vmcount
$json | Add-Member -Type NoteProperty -Name "SwitchCount" -Value $Scount
$i = 0
foreach($vhd in $vhds)
{
$imagepath= $imagepath+$i
$vmname = "VM"+$i
$imagepath = $fname +"\"+$vhd
#$imagepath = $imagepath.Replace('\', '\\')
$json | Add-Member -Type NoteProperty -Name $vmname -Value $imagepath
$i++
}
$json | ConvertTo-json | Out-File .\sample.json
