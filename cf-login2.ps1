$out = "$env:USERPROFILE\cf-login2.out"
Remove-Item $out -Force -ErrorAction SilentlyContinue
$cmdline = 'cmd /c ""C:\Program Files (x86)\cloudflared\cloudflared.exe" tunnel login > "' + $out + '" 2>&1"'
$r = Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{ CommandLine = $cmdline }
Write-Output "CREATE_RC: $($r.ReturnValue) PID: $($r.ProcessId)"
Start-Sleep -Seconds 6
Write-Output "---OUT---"
Get-Content $out -ErrorAction SilentlyContinue
