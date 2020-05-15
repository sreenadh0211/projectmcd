$json = Get-Content '.\payload.json' | Out-String | ConvertFrom-Json
#$json | ConvertTo-json
$totalVMcount = ($json.vLABCONFIG.VM).Count
$totalNICcount = ($json.vLABCONFIG.NIC).Count
if($totalNICcount -lt 1)
{
$NICname = $json.vLABCONFIG.NIC.Name
$AdapterName = $json.vLABCONFIG.NIC.NetAdapterName
$SwitchType = $json.vLABCONFIG.NIC.SwitchType
}
$POSCount= 0
$WinCount= 0
$ServerCount= 0

$i=1
$vmnames = $json.vLABCONFIG.VM.VMName
foreach($vmname in $vmnames){
$newvmnumber = "VM"+$i
$newvmname = $vmname
$i++
}


$imagepaths = $json.vLABCONFIG.VM.VHDPath.path
foreach($imagepath in $imagepaths){
if($imagepath -like '*POS*'){$POSCount++}
elseif($imagepath -like '*KVS*'){$WinCount++}
elseif($imagepath -like '*server2012*'){$ServerCount++}
else{write-host "not found"}
}
$ram = ($json.vLABCONFIG.VM.Ram | Get-Unique | Sort-Object -Descending | Select-Object -Last 1).ToString()
$processors = ($json.vLABCONFIG.VM.core | Get-Unique | Sort-Object -Descending | Select-Object -First 1).ToString()
$path = ($json.vLABCONFIG.VM.path) | Get-Unique
$templateVhdpath = ($json.vLABCONFIG.VM.VirtualLabVhdpath) | Get-Unique
$imagepathone= ($imagepaths | Select-Object -First 1)
$vhdxpath = Split-Path -path $imagepathone
$gscRam = ($json.vLABCONFIG.VM | Where-Object {$_.Image -eq 'Server2012'}).RAM
#if($json.vLABCONFIG.VM.VMName -eq "BOS_server"){

#($json.vLABCONFIG.VM | Where-Object {$_.VMName -eq 'BOS_server'}).VHDPath.path
$vmdetail = @{"VMCount"=$totalVMcount.ToString(); "posVMCount"=$POSCount.ToString(); "kvsVMCount"=$WinCount.ToString(); "gscVMCount"=$ServerCount.ToString();
"NicName"=$NICname; "NicAdapterName"=$AdapterName; "SwitchType"=$SwitchType; "ram"=$ram; "processors"=$processors;  "SwitchCount"="2"; "path"=$path; "destVhdpath"= $templateVhdpath;
"SourceVhdpath"=$vhdxpath; "min_ram"="1024"; "generation"= "1"; "gscRam" = $gscRam.ToString()
}
$vmdetail | ConvertTo-Json