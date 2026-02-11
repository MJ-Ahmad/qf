# tools/reset-css-style.ps1
# Reset css/style.css into human-readable format (in-place, UTF-8 without BOM)

$path = "css/style.css"

if (Test-Path $path) {
    # Read entire file
    $css = Get-Content $path -Raw

    # Normalize line endings and trim
    $css = $css -replace "`r`n", "`n"
    $css = $css.Trim()

    # Insert line breaks around braces and semicolons to create structure
    $css = $css -replace '\s*{\s*', " {`n"
    $css = $css -replace '\s*}\s*', "`n}`n"
    $css = $css -replace ';', ";`n"

    # Collapse multiple blank lines
    $css = $css -replace '(\n){2,}', "`n"

    # Indentation: build formatted lines with nesting based on braces
    $lines = $css -split "`n"
    $indent = 0
    $formattedLines = New-Object System.Collections.Generic.List[string]

    foreach ($line in $lines) {
        $trim = $line.Trim()
        if ($trim -eq '') { continue }

        if ($trim -match '^\}') {
            $indent = [Math]::Max(0, $indent - 1)
        }

        $indented = ('    ' * $indent) + $trim
        $formattedLines.Add($indented)

        if ($trim -match '\{$') {
            $indent++
        }
    }

    # Write back to the same file (UTF8 without BOM)
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllLines($path, $formattedLines, $utf8NoBom)

    Write-Host "CSS file has been reset to human-readable format."
} else {
    Write-Host "File not found: $path"
}
