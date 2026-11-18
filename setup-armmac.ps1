$ErrorActionPreference = 'Continue'
$key = "$env:USERPROFILE\.ssh\id_ed25519_armmac"
if (-not (Test-Path $key)) {
  ssh-keygen -t ed25519 -f $key -N "" -C "armmac"
  Write-Output "KEY_GENERATED"
} else {
  Write-Output "KEY_EXISTS"
}
Write-Output "PUBKEY_BEGIN"
Get-Content "$key.pub"
Write-Output "PUBKEY_END"
$cf = Get-Command cloudflared -ErrorAction SilentlyContinue
if ($cf) {
  Write-Output "CLOUDFLARED_FOUND: $($cf.Source)"
} else {
  Write-Output "INSTALLING_CLOUDFLARED"
  winget install --id Cloudflare.cloudflared --exact --accept-source-agreements --accept-package-agreements --silent
  Write-Output "WINGET_EXIT: $LASTEXITCODE"
}
