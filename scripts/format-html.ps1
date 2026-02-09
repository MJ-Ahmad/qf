<#
    Script Name : format-html.ps1
    Owner       : MJ-Ahmad
    Purpose     : Reset and format an HTML file into a human-readable structure with proper indentation.
    Policy      : This script is intended for stewardship use only. It must be run with care, as it overwrites the target file directly.
    Date        : 2026-02-09
    Notes       : The script reads the HTML file, applies indentation rules, and saves it back in place.
#>

$inputFile  = "E:\QuranerFariwala\qf\app\faq.html"

# Read the HTML content
$htmlContent = Get-Content $inputFile -Raw

# Regex-based indentation logic
$indentLevel = 0
$formattedLines = @()

foreach ($segment in ($htmlContent -split '(?=<)')) {
    $line = $segment.Trim()
    if ([string]::IsNullOrWhiteSpace($line)) { continue }

    # Decrease indent for closing tags
    if ($line -match '^</') {
        if ($indentLevel -gt 0) { $indentLevel-- }
    }

    # Add line with current indentation
    $formattedLines += (" " * ($indentLevel * 2)) + $line

    # Increase indent for opening tags (excluding self-closing and void tags)
    if ($line -match '^<[^/!][^>]*[^/]>$' -and
        $line -notmatch '<meta' -and
        $line -notmatch '<link' -and
        $line -notmatch '<img' -and
        $line -notmatch '<br' -and
        $line -notmatch '<hr') {
        $indentLevel++
    }
}

# Overwrite the same file with formatted content
$formattedLines | Out-File $inputFile -Encoding utf8

Write-Output "✅ faq.html has been reset and saved in human-readable format."
