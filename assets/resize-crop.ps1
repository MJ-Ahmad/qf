# resize-crop.ps1
param(
  [string]$SourceFolder = ".\footer",
  [string]$OutputFolder = ".\footer_resized",
  [int]$Width = 800,
  [int]$Height = 600,
  [switch]$Recursive
)

if (!(Test-Path $OutputFolder)) { New-Item -ItemType Directory -Path $OutputFolder | Out-Null }

Get-ChildItem -Path $SourceFolder -Include *.jpg,*.jpeg,*.png -File -Recurse:($Recursive.IsPresent) | ForEach-Object {
  $rel = $_.FullName.Substring((Resolve-Path $SourceFolder).Path.Length).TrimStart('\','/')
  $outFile = Join-Path $OutputFolder $rel
  New-Item -ItemType Directory -Path (Split-Path $outFile) -Force | Out-Null

  # Resize to cover, then center crop
  magick $_.FullName -resize "${Width}x${Height}^" -gravity center -extent "${Width}x${Height}" $outFile
  Write-Host "Cropped: $($_.Name) -> $outFile"
}
