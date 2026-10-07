<#
    Script Name : compress-html.ps1
    Owner       : MJ-Ahmad
    Purpose     : Reset a human-readable HTML file into machine-readable single-line format.
    Policy      : This script overwrites the target file directly. Use with caution, as all indentation and line breaks will be removed.
    Date        : 2026-02-09
    Notes       : The script reads the HTML file, strips whitespace and newlines, and saves it back in place as one line.
#>

$inputFile  = "E:\QuranerFariwala\qf\app\index.html"

# Read the HTML content
$htmlContent = Get-Content $inputFile -Raw

# Replace all whitespace and newlines with single spaces, then trim
$compressed = ($htmlContent -replace '\s+', ' ').Trim()

# Overwrite the same file with compressed content
$compressed | Out-File $inputFile -Encoding utf8 -NoNewline

Write-Output "✅ faq.html has been reset and saved in machine-readable single-line format."
