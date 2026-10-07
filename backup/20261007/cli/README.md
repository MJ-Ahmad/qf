\# CLI — Reset CSS Style



\## Overview

This small static project provides a professional viewer for a PowerShell script that reformats a minified `css/style.css` file into a human-readable, indented file. The PowerShell script overwrites the original file in-place (UTF-8 without BOM).



\## Project structure

```

cli/

├─ index.html

├─ css/style.css

├─ js/script.js

├─ assets/fonts/Inter-Variable.woff2

├─ assets/images/logo.svg

├─ tools/reset-css-style.ps1

├─ README.md

└─ .gitignore

```



\## Quick start (view)

1\. Place `Inter-Variable.woff2` at `assets/fonts/Inter-Variable.woff2`.

2\. Open `index.html` in a browser, or serve the folder:

&#x20;  - Python: `python -m http.server 8000`

&#x20;  - Node: `npx http-server -c-1`

3\. Use the page controls to copy or download the PowerShell script.



\## Run the PowerShell script (format css/style.css)

> \*\*Warning:\*\* The script overwrites `css/style.css` in-place. Back up the file if needed.



From the `cli/` folder in PowerShell:

```powershell

\# run the tool script

.\\tools\\reset-css-style.ps1

```



\## Verify font integrity (example)

```powershell

Get-FileHash "assets/fonts/Inter-Variable.woff2" -Algorithm SHA256

```

Save the resulting hash for future verification.



\## Notes

\- The `@font-face` in `css/style.css` expects the font at `assets/fonts/Inter-Variable.woff2`.

\- If you prefer a hosted font, replace the `@font-face` with a Google Fonts link.

\- For production, consider subsetting the font and enabling long cache headers.



\## License

Check the license of any fonts or third-party assets before redistribution. Inter is typically distributed under the SIL Open Font License.



\---



\### `.gitignore`

```

\# Node / build

node\_modules/

dist/

build/



\# OS

.DS\_Store

Thumbs.db



\# Logs

\*.log



\# Editor

.vscode/

.idea/



\# Generated

\*.bak

```

\---



\### Final notes and checklist

\- \*\*Place the font\*\* at `assets/fonts/Inter-Variable.woff2`. You already verified the file exists and computed its SHA‑256 hash — keep that hash in a checksum file if desired.

\- \*\*Test locally\*\* by serving the `cli/` folder and opening `index.html`.

\- \*\*Run the PowerShell script\*\* from the `cli/` root to reformat `css/style.css`.

\- \*\*Back up\*\* `css/style.css` before running the script if you need to preserve the original.





