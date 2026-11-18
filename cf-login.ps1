$cf = "C:\Program Files (x86)\cloudflared\cloudflared.exe"
$out = "$env:USERPROFILE\cf-login.out"
$err = "$env:USERPROFILE\cf-login.err"
Remove-Item $out, $err -Force -ErrorAction SilentlyContinue
Start-Process -FilePath $cf -ArgumentList 'tunnel','login' -RedirectStandardOutput $out -RedirectStandardError $err -NoNewWindow
Start-Sleep -Seconds 6
Write-Output "---STDERR---"
Get-Content $err -ErrorAction SilentlyContinue
Write-Output "---STDOUT---"
Get-Content $out -ErrorAction SilentlyContinue
Write-Output "---CERT---"
Test-Path "$env:USERPROFILE\.cloudflared\cert.pem"
