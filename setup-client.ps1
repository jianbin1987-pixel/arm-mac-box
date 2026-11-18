$cfgPath = "$env:USERPROFILE\.ssh\config"
Copy-Item $cfgPath "$cfgPath.bak-armmac" -Force
$cfg = Get-Content $cfgPath -Raw
if ($cfg -notmatch 'Host armmac') {
  $block = @"

Host armmac
    HostName mac.mytokens.shop
    User runner
    IdentityFile ~/.ssh/id_ed25519_armmac
    IdentitiesOnly yes
    StrictHostKeyChecking accept-new
    ProxyCommand "C:\Program Files (x86)\cloudflared\cloudflared.exe" access ssh --hostname %h
"@
  Add-Content -Path $cfgPath -Value $block -Encoding ascii
  Write-Output "CONFIG_APPENDED"
} else {
  Write-Output "CONFIG_ALREADY_HAS_ARMMAC"
}
$cmd = "@echo off`r`necho Connecting to ARM Mac (mac.mytokens.shop) ...`r`nssh armmac`r`npause`r`n"
Set-Content -Path "$env:USERPROFILE\Desktop\ArmMac.cmd" -Value $cmd -Encoding ascii
Write-Output "DESKTOP_CMD_WRITTEN"
Get-Content $cfgPath -Tail 9
