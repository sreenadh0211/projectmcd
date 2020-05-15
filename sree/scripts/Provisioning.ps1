$User = "administrator"
$PWord = ConvertTo-SecureString -String "Ark674!10" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
#$Cred =  Get-Credential
# you might first need to enable-psremoting on it 
#Enable-PSRemoting -Force
$remotecomputername = "JP99901POS01"
#$S = New-PSSession -VMName VM1 -Credential $Credential
If(Test-Connection -ComputerName $remotecomputername -Quiet){
$S= New-PSSession -ComputerName $remotecomputername -Credential $Credential
}
Invoke-Command -Session $S -ScriptBlock {Rename-Computer -NewName WDS01 -Force}
Invoke-Command -Session $S -ScriptBlock {Restart-Computer -Force}
Start-Sleep -Seconds 60
$S = New-PSSession -ComputerName WDS01 -Credential $Credential
Invoke-Command -Session $S -ScriptBlock {Get-Service -Name N* }
#Enter-PSSession -VMName VM1 -Credential $Credential
#Rename-Computer -ComputerName $newComputerName
Copy-Item -ToSession $S -Path S:\VirtualLabs\Sample.ps1 -Destination E:\
Copy-Item -ToSession $S -Path S:\VirtualLabs\npp.7.8.6.Installer.exe -Destination E:\


