$json = Get-Content '.\vmdata.json' | Out-String | ConvertFrom-Json
$json | ConvertTo-json