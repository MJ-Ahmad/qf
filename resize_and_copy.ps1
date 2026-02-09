<#
.SYNOPSIS
  Source ডিরেক্টরি থেকে ছবি নিয়ে নির্দিষ্ট রেজুলিউশনে রিসাইজ ও প্যাড করে target ডিরেক্টরিতে সংরক্ষণ করবে।

.DESCRIPTION
  - Source: E:\QF\qf\assets\qf\
  - Destination: E:\QF\qf\assets\qf_copy\
  - Aspect ratio বজায় রেখে রিসাইজ করবে এবং প্রয়োজন হলে background দিয়ে প্যাড করবে যাতে সব ছবি একই width x height হয়।
  - JPEG এর ক্ষেত্রে quality সেট করা যাবে।
  - corrupted/invalid images skip করে log করবে।

.NOTES
  - Windows PowerShell (Desktop) এ পরীক্ষা করা হয়েছে।
  - বড় পরিমাণ ইমেজ হলে পর্যাপ্ত ডিস্ক স্পেস ও মেমোরি নিশ্চিত করুন।
#>

# --- Configuration ---
$SourceDir = "E:\QF\qf\assets\qf\"
$DestDir   = "E:\QF\qf\assets\qf_copy\"

# Target dimensions (পছন্দমতো পরিবর্তন করুন)
$TargetWidth  = 1200   # px
$TargetHeight = 800    # px

# JPEG quality (1-100)
$JpegQuality = 90

# Background color for padding (RGB)
$BackgroundColor = [System.Drawing.Color]::White

# Log file
$LogFile = Join-Path -Path $DestDir -ChildPath "resize_log.txt"

# Supported extensions (case-insensitive)
$Extensions = @(".jpg", ".jpeg", ".png", ".gif", ".bmp", ".tiff", ".webp")

# --- Ensure destination exists ---
if (-not (Test-Path -Path $DestDir)) {
    New-Item -ItemType Directory -Path $DestDir -Force | Out-Null
}

# Initialize log
"=== Resize run: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ===" | Out-File -FilePath $LogFile -Encoding UTF8 -Append

# Helper: get image encoder for format
function Get-ImageCodecInfo([string]$mime) {
    $encoders = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders()
    foreach ($e in $encoders) {
        if ($e.MimeType -eq $mime) { return $e }
    }
    return $null
}

# Helper: save image with quality for JPEG
function Save-ImageWithQuality([System.Drawing.Image]$bitmap, [string]$outPath, [string]$ext) {
    $extLower = $ext.ToLower()
    switch ($extLower) {
        ".jpg" { $mime = "image/jpeg" }
        ".jpeg"{ $mime = "image/jpeg" }
        ".png" { $mime = "image/png" }
        ".gif" { $mime = "image/gif" }
        ".bmp" { $mime = "image/bmp" }
        ".tiff"{ $mime = "image/tiff" }
        default { $mime = "image/jpeg" }
    }

    $codec = Get-ImageCodecInfo $mime
    if ($codec -and ($mime -eq "image/jpeg")) {
        $encParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
        $encParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [int]$JpegQuality)
        $bitmap.Save($outPath, $codec, $encParams)
    } elseif ($codec) {
        $bitmap.Save($outPath, $codec, $null)
    } else {
        # fallback
        $bitmap.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    }
}

# Main processing
Add-Type -AssemblyName System.Drawing

$files = Get-ChildItem -Path $SourceDir -File -Recurse | Where-Object { $Extensions -contains $_.Extension.ToLower() }

if ($files.Count -eq 0) {
    "No image files found in $SourceDir" | Tee-Object -FilePath $LogFile -Append
    Write-Host "No image files found in $SourceDir"
    exit 0
}

foreach ($file in $files) {
    $srcPath = $file.FullName
    $relPath = $file.FullName.Substring($SourceDir.Length).TrimStart('\','/')
    $destPath = Join-Path -Path $DestDir -ChildPath $relPath

    # Ensure destination subfolder exists
    $destFolder = Split-Path -Path $destPath -Parent
    if (-not (Test-Path -Path $destFolder)) {
        New-Item -ItemType Directory -Path $destFolder -Force | Out-Null
    }

    try {
        # Load image
        $img = [System.Drawing.Image]::FromFile($srcPath)

        # Compute scale to fit while preserving aspect ratio
        $srcW = $img.Width
        $srcH = $img.Height

        if ($srcW -eq 0 -or $srcH -eq 0) {
            throw "Invalid image dimensions"
        }

        $scale = [math]::Min($TargetWidth / $srcW, $TargetHeight / $srcH)
        $newW = [int]([math]::Round($srcW * $scale))
        $newH = [int]([math]::Round($srcH * $scale))

        # Create target bitmap and draw with high quality settings
        $targetBitmap = New-Object System.Drawing.Bitmap $TargetWidth, $TargetHeight
        $g = [System.Drawing.Graphics]::FromImage($targetBitmap)
        try {
            $g.Clear($BackgroundColor)
            $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
            $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
            $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
            $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality

            # Compute offsets to center the resized image
            $offsetX = [int](([math]::Round(($TargetWidth - $newW) / 2)))
            $offsetY = [int](([math]::Round(($TargetHeight - $newH) / 2)))

            # Draw resized image
            $g.DrawImage($img, $offsetX, $offsetY, $newW, $newH)
        } finally {
            $g.Dispose()
        }

        # Save with appropriate encoder/quality
        $ext = $file.Extension
        # Ensure destPath has same extension
        $destPathNormalized = $destPath
        Save-ImageWithQuality -bitmap $targetBitmap -outPath $destPathNormalized -ext $ext

        # Dispose bitmaps
        $targetBitmap.Dispose()
        $img.Dispose()

        $msg = "OK: $relPath -> saved as $destPathNormalized (resized to ${TargetWidth}x${TargetHeight})"
        $msg | Tee-Object -FilePath $LogFile -Append
        Write-Host $msg -ForegroundColor Green
    } catch {
        $err = $_.Exception.Message
        $msg = "ERROR: $relPath -> $err"
        $msg | Tee-Object -FilePath $LogFile -Append
        Write-Host $msg -ForegroundColor Red
        # Attempt to cleanup any partially created file
        try { if (Test-Path $destPath) { Remove-Item $destPath -Force -ErrorAction SilentlyContinue } } catch {}
    }
}

"=== Completed: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ===`n" | Out-File -FilePath $LogFile -Encoding UTF8 -Append
Write-Host "Processing complete. Log: $LogFile"
