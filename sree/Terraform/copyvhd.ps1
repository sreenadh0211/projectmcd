function Copy-File {
    param( [string]$from, [string]$to)
    $ffile = [io.file]::OpenRead($from)
    $tofile = [io.file]::OpenWrite($to)
    Write-Progress -Activity "Copying file" -status "$from -> $to" -PercentComplete 0
    try {
        [byte[]]$buff = new-object byte[] 4096
        [long]$total = [long]$count = 0
        do {
            $count = $ffile.Read($buff, 0, $buff.Length)
            $tofile.Write($buff, 0, $count)
            $total += $count
            if ($total % 1mb -eq 0) {
                Write-Progress -Activity "Copying file" -status "$from -> $to" `
                   -PercentComplete ([long]($total/$ffile.Length* 100))
            }
        } while ($count -gt 0)
    }
    finally {
        $ffile.Dispose()
        $tofile.Dispose()
        Write-Progress -Activity "Copying file" -Status "Ready" -Completed
    }
}
$POSCount= 0
$WinCount= 0
$ServerCount= 0

#$json = Get-Content '.\ImportPayload.json' | Out-String | ConvertFrom-Json
$json = Get-Content '.\payload.json' | Out-String | ConvertFrom-Json


$imagepaths = $json.vLABCONFIG.VM.VHDPath.path
foreach($imagepath in $imagepaths){
if($imagepath -like '*POS*'){$POSCount++}
elseif($imagepath -like '*KVS*'){$WinCount++}
elseif($imagepath -like '*server2012*'){$ServerCount++}
else{write-host "not found"}
}

$PosVMCount = $POSCount
$KvsVMCount = $WinCount
$gscVMCount = $ServerCount

$imagepathone= ($imagepaths | Select-Object -First 1)
$sourceVhdPath = Split-Path -path $imagepathone

#$sourceVhdPath = $json.SourceVhdpath
$destVhdPath= ($json.vLABCONFIG.VM.VirtualLabVhdpath) | Get-Unique

$posVhdx = $sourceVhdPath+"\POS_PR7.vhdx"
$KVSVhdx = $sourceVhdPath+"\KVS_PR7.vhdx"
$gscVhdx = $sourceVhdPath+"\server2012.vhdx"

if((test-path -path $posVhdx) -eq 'True')
    {
        write-host "Source POS vhdx file avaiable"
        for($i = 0; $i -lt $PosVMCount; $i++){
                        $newfilepath = "POS"+$i+".vhdx"
                            if((test-path -path $destVhdPath\$newfilepath) -eq 'True') { write-host "File is already there in destination folder, no need to copy"}
                            else {Copy-File $posVhdx $destVhdPath\$newfilepath}
                                         }
        }
else{
    Write-Host "Source POS vhdx is not there, so skipping copy file step"
    }

if((test-path -path $KVSVhdx) -eq 'True')
    {
        write-host "Source KVS vhdx file avaiable"
        for($i = 0; $i -lt $KvsVMCount; $i++){
                        $newfilepath = "KVS"+$i+".vhdx"
                            if((test-path -path $destVhdPath\$newfilepath) -eq 'True') { write-host "File is already there in destination folder, no need to copy"}
                            else {Copy-File $KVSVhdx $destVhdPath\$newfilepath}
                                         }
        }

if((test-path -path $gscVhdx) -eq 'True')
    {
        write-host "Source GSC vhdx file avaiable"
        for($i = 0; $i -lt $gscVMCount; $i++){
                        $newfilepath = "GSC"+$i+".vhdx"
                            if((test-path -path $destVhdPath\$newfilepath) -eq 'True') { write-host "File is already there in destination folder, no need to copy"}
                            else {Copy-File $gscVhdx $destVhdPath\$newfilepath}
                                         }
        }
else{
    Write-Host "Source KVS vhdx is not there, so skipping copy file step"
    }