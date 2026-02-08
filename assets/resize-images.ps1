param(
  [string]$SourceFolder = ".\qf",
  [string]$OutputFolder = ".\qf_resized",
  [int]$Width = 800,
  [int]$Height = 600,
  [int]$Quality = 90,
  [switch]$Recursive
)

# Ensure source exists
if (!(Test-Path -Path $SourceFolder)) {
  Write-Error "Source folder not found: $SourceFolder"
  exit 1
}

# Create output folder
if (!(Test-Path -Path $OutputFolder)) {
  New-Item -ItemType Directory -Path $OutputFolder | Out-Null
}

# Gather files
$searchOption = if ($Recursive) { [System.IO.SearchOption]::AllDirectories } else { [System.IO.SearchOption]::TopDirectoryOnly }
$files = Get-ChildItem -Path $SourceFolder -Include *.jpg, *.jpeg, *.png -File -Recurse:($Recursive.IsPresent)

if ($files.Count -eq 0) {
  Write-Host "No images found in $SourceFolder"
  exit 0
}

foreach ($f in $files) {
  try {
    # Build relative path to preserve folder structure
    $srcRoot = (Resolve-Path $SourceFolder).Path.TrimEnd('\','/')
    $fullPath = (Resolve-Path $f.FullName).Path
    $relative = $fullPath.Substring($srcRoot.Length).TrimStart('\','/')
    $outDir = Join-Path $OutputFolder ([System.IO.Path]::GetDirectoryName($relative))
    if (!(Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir -Force | Out-Null }
    $outFile = Join-Path $outDir $f.Name

    # Build ImageMagick command:
    # -resize WxH^  -> scale to cover (may exceed one dimension)
    # -gravity center -extent WxH -> center-crop to exact size
    # For JPEG, set quality; for PNG, keep default
    $ext = $f.Extension.ToLower()
    if ($ext -in @(".jpg", ".jpeg")) {
      $cmd = "magick `"$($f.FullName)`" -resize ${Width}x${Height}^ -gravity center -extent ${Width}x${Height} -quality $Quality `"$outFile`""
    } else {
      $cmd = "magick `"$($f.FullName)`" -resize ${Width}x${Height}^ -gravity center -extent ${Width}x${Height} `"$outFile`""
    }

    # Execute via cmd to ensure proper quoting on Windows
    & cmd /c $cmd

    if ($LASTEXITCODE -eq 0) {
      Write-Host "Resized: $($f.FullName) -> $outFile"
    } else {
      Write-Warning "ImageMagick failed for: $($f.FullName)"
    }
  } catch {
    Write-Warning "Error processing $($f.FullName): $($_.Exception.Message)"
  }
}
