# Init-Project.ps1
param (
    [string]$ProjectRoot = "A_Journey_of_Light"
)

$folders = @(
    "docs", "assets/images", "assets/templates/social-posts",
    "data", "scripts", "modules", "tests", ".github/workflows"
)

foreach ($folder in $folders) {
    $path = Join-Path $ProjectRoot $folder
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path -Force | Out-Null
    }
}

# Create README.md
$readme = @"
# A Journey of Light

This project ritualizes the printing and distribution of 40,000 memorization-optimized Qur’ans across Bangladesh. Every script, folder, and document is a constitutional artifact for future guardians.

Run `Init-Project.ps1` to scaffold the structure.
"@
Set-Content -Path "$ProjectRoot\README.md" -Value $readme

# Create CHANGELOG.md
Set-Content -Path "$ProjectRoot\CHANGELOG.md" -Value "# Changelog`n`n- Initialized project structure on $(Get-Date -Format 'yyyy-MM-dd')"

Write-Host "✅ Project scaffolded at $ProjectRoot"
