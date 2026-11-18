$cf = "C:\Program Files (x86)\cloudflared\cloudflared.exe"
$cert = "$env:USERPROFILE\.cloudflared\cert.pem"
Write-Output "CERT_EXISTS: $(Test-Path $cert)"
Write-Output "---CREATE---"
& $cf tunnel create arm-mac 2>&1 | Out-String | Write-Output
Write-Output "---ROUTE---"
& $cf tunnel route dns arm-mac mac.mytokens.shop 2>&1 | Out-String | Write-Output
& $cf tunnel token arm-mac > "$env:USERPROFILE\cf-token.txt" 2>$null
Write-Output "TOKEN_FILE_WRITTEN: $(Test-Path "$env:USERPROFILE\cf-token.txt")"
Write-Output "---LIST---"
& $cf tunnel list 2>&1 | Out-String | Write-Output
