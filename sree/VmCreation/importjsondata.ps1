$json = Get-Content '.\sample.json' | Out-String | ConvertFrom-Json
$json | ConvertTo-json