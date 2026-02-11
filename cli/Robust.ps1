$uri = "https://raw.githubusercontent.com/rsms/inter/master/docs/font-files/InterVariable.woff2"
$out = "assets/fonts/Inter-Variable.woff2"
New-Item -ItemType Directory -Force -Path (Split-Path $out) | Out-Null

$maxAttempts = 3
for ($i=1; $i -le $maxAttempts; $i++) {
    try {
        Write-Host "Downloading (attempt $i) ..."
        Invoke-WebRequest -Uri $uri -OutFile $out -UseBasicParsing -TimeoutSec 60 -Verbose
        Write-Host "Downloaded to $out"
        break
    } catch {
        Write-Warning "Attempt $i failed: $($_.Exception.Message)"
        if ($i -eq $maxAttempts) { throw "Download failed after $maxAttempts attempts." }
        Start-Sleep -Seconds (5 * $i)
    }
}
