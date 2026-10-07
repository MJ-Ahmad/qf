// js/script.js
// Injects the PowerShell script into the page, provides copy/download/collapse features,
// and applies lightweight syntax highlighting.

const rawScript = `# Reset css/style.css into human-readable format
# No copy will be created, file will be overwritten in-place

$path = "css/style.css"

if (Test-Path $path) {
    # Read full CSS content
    $css = Get-Content $path -Raw

    # Normalize line endings and remove leading/trailing whitespace
    $css = $css -replace "\`r\`n", "\`n"
    $css = $css.Trim()

    # Insert line breaks around braces and semicolons to create structure
    $css = $css -replace '\\s*{\\s*', " {\\n"
    $css = $css -replace '\\s*}\\s*', "\\n}\\n"
    $css = $css -replace ';', ";\\n"

    # Collapse multiple blank lines
    $css = $css -replace '(\\n){2,}', "\\n"

    # Indentation: build formatted lines with nesting based on braces
    $lines = $css -split "\\n"
    $indent = 0
    $formattedLines = New-Object System.Collections.Generic.List[string]

    foreach ($line in $lines) {
        $trim = $line.Trim()
        if ($trim -eq '') { continue }

        if ($trim -match '^\\}') {
            $indent = [Math]::Max(0, $indent - 1)
        }

        $indented = ('    ' * $indent) + $trim
        $formattedLines.Add($indented)

        if ($trim -match '\\{$') {
            $indent++
        }
    }

    # Write back to the same file (UTF8 without BOM)
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllLines($path, $formattedLines, $utf8NoBom)

    Write-Host "CSS file has been reset to human-readable format."
} else {
    Write-Host "File not found: $path"
}`;

// Utility: escape HTML
function esc(s){ return s.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;'); }

// Lightweight highlighter: comments, strings, variables, keywords
function highlight(text){
  return esc(text)
    .replace(/#.*$/gm, m => `<span class="tok-comment">${m}</span>`)
    .replace(/"([^"\\]|\\.)*"/g, m => `<span class="tok-str">${m}</span>`)
    .replace(/\$[A-Za-z0-9_]+/g, m => `<span class="tok-var">${m}</span>`)
    .replace(/\b(if|else|foreach|in|New-Object|Write-Host|Set-Content|Get-Content|Test-Path|Trim|Split)\b/g, m => `<span class="tok-key">${m}</span>`);
}

// Render with simple line numbers
function renderWithGutter(text){
  const lines = text.split('\n');
  const gutter = lines.map((_,i) => `<div>${String(i+1).padStart(3,' ')}</div>`).join('');
  const content = lines.map(l => `<div>${highlight(l)}</div>`).join('');
  return `<div style="display:grid;grid-template-columns:auto 1fr;gap:18px;align-items:start;">
    <div class="gutter" style="text-align:right;padding-right:12px;color:rgba(255,255,255,0.18);font-size:12px">${gutter}</div>
    <div class="code-content">${content}</div>
  </div>`;
}

// DOM elements
const codeBlock = document.getElementById('codeBlock');
const copyBtn = document.getElementById('copyBtn');
const downloadBtn = document.getElementById('downloadBtn');
const collapseBtn = document.getElementById('collapseBtn');

// Initial render
codeBlock.innerHTML = renderWithGutter(rawScript);

// Copy to clipboard
copyBtn.addEventListener('click', async () => {
  try {
    await navigator.clipboard.writeText(rawScript.trim());
    copyBtn.textContent = '✅ Copied';
    setTimeout(()=> copyBtn.textContent = '📋 Copy Script', 1600);
  } catch {
    alert('Copy failed. Select and copy manually.');
  }
});

// Download .ps1
downloadBtn.addEventListener('click', () => {
  const blob = new Blob([rawScript], {type:'text/plain;charset=utf-8'});
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url; a.download = 'reset-css-style.ps1';
  document.body.appendChild(a); a.click(); a.remove();
  URL.revokeObjectURL(url);
  downloadBtn.textContent = '⬇️ Downloaded';
  setTimeout(()=> downloadBtn.textContent = '⬇️ Download .ps1', 1400);
});

// Collapse toggle
let collapsed = false;
const COLLAPSE_LINES = 12;
collapseBtn.addEventListener('click', () => {
  collapsed = !collapsed;
  if (collapsed) {
    const lines = rawScript.split('\n');
    const preview = lines.slice(0, COLLAPSE_LINES).join('\n') + '\n…';
    codeBlock.innerHTML = renderWithGutter(preview);
    collapseBtn.textContent = 'Expand';
  } else {
    codeBlock.innerHTML = renderWithGutter(rawScript);
    collapseBtn.textContent = 'Toggle Collapse';
  }
});

// Keyboard shortcut: Ctrl/C to copy when code block focused
codeBlock.addEventListener('keydown', function(e){
  if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 'c'){
    navigator.clipboard.writeText(rawScript.trim()).then(()=> {
      copyBtn.textContent = '✅ Copied';
      setTimeout(()=> copyBtn.textContent = '📋 Copy Script', 1400);
    });
    e.preventDefault();
  }
});
