$key = "$env:USERPROFILE\.ssh\id_ed25519_armmac"
if (Test-Path $key) { Remove-Item $key -Force }
if (Test-Path "$key.pub") { Remove-Item "$key.pub" -Force }
$cmdline = 'ssh-keygen -t ed25519 -f "' + $key + '" -N "" -C armmac'
cmd /c $cmdline
Write-Output "PUBKEY_BEGIN"
Get-Content "$key.pub"
Write-Output "PUBKEY_END"
