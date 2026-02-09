\### README



\#### Overview

This repository contains three PowerShell scripts that resize images in a source folder and write outputs to target folders. Each script uses ImageMagick (`magick`) for high-quality image processing. Use them to produce consistent image dimensions for web galleries, thumbnails, or archives.



\#### Scripts Included

\- \*\*resize-images.ps1\*\*  

&#x20; Resizes images to a fixed size while preserving quality and optionally preserving folder structure. Supports JPEG quality control and recursive processing. Default example: `-SourceFolder ".\\qf" -OutputFolder ".\\qf\_resized" -Width 800 -Height 600 -Quality 90 -Recursive`.



\- \*\*resize-stretch.ps1\*\*  

&#x20; Forces each image to the exact target dimensions by stretching (aspect ratio will not be preserved). Output folder default: `qf\_resized1`.



\- \*\*resize-crop.ps1\*\*  

&#x20; Resizes images to cover the target area while preserving aspect ratio, then center-crops to exact dimensions (no white bars). Output folder default: `qf\_resized2`.



\#### Requirements and Installation

\- \*\*ImageMagick\*\* must be installed and available on PATH. Verify with:

```powershell

magick -version

```

\- \*\*PowerShell\*\* (Windows PowerShell or PowerShell Core) to run the scripts.

\- Place scripts in a folder and run them from a PowerShell prompt with appropriate permissions.



\#### Usage Examples

\*\*Resize with quality and recursion\*\*

```powershell

.\\resize-images.ps1 -SourceFolder ".\\qf" -OutputFolder ".\\qf\_resized" -Width 800 -Height 600 -Quality 90 -Recursive

```



\*\*Stretch to exact size (force)\*\*

```powershell

.\\resize-stretch.ps1 -SourceFolder ".\\qf" -OutputFolder ".\\qf\_resized1" -Width 800 -Height 600 -Recursive

```



\*\*Cover and center-crop\*\*

```powershell

.\\resize-crop.ps1 -SourceFolder ".\\qf" -OutputFolder ".\\qf\_resized2" -Width 800 -Height 600 -Recursive

```



\*\*One-line quick run (example)\*\*

```powershell

magick "E:\\QuranerFariwala\\qf\\assets\\qf\\01.jpg" -resize 800x600^ -gravity center -extent 800x600 "E:\\QuranerFariwala\\qf\\assets\\qf\_resized\\01.jpg"

```



\#### Behavior Details and Options

\- \*\*Preserve folder structure\*\*  

&#x20; When `-Recursive` is used, subfolders under the source folder are mirrored in the output folder.



\- \*\*Output folders\*\*  

&#x20; - `qf\_resized` — output from `resize-images.ps1` (quality-controlled JPEGs and PNGs).  

&#x20; - `qf\_resized1` — output from `resize-stretch.ps1` (stretched images).  

&#x20; - `qf\_resized2` — output from `resize-crop.ps1` (cover + center-crop).



\- \*\*Resize modes\*\*  

&#x20; - \*\*Stretch\*\*: `-resize WIDTHxHEIGHT!` — forces exact dimensions, may distort images.  

&#x20; - \*\*Crop\*\*: `-resize WIDTHxHEIGHT^ -gravity center -extent WIDTHxHEIGHT` — preserves aspect ratio, crops excess.  

&#x20; - \*\*Cover + center-crop\*\* is recommended for consistent visual results without white bars.



\- \*\*JPEG quality\*\*  

&#x20; `resize-images.ps1` accepts `-Quality` to control JPEG compression (default example uses 90). Lower values reduce file size.



\- \*\*File types\*\*  

&#x20; Scripts process `\*.jpg`, `\*.jpeg`, and `\*.png`. Other formats can be added by editing the file filter.



\#### Troubleshooting and Notes

\- \*\*magick not found\*\*  

&#x20; If `magick` is not recognized, add ImageMagick installation folder to PATH or run with the full path to `magick.exe`.



\- \*\*No images found\*\*  

&#x20; Confirm the `-SourceFolder` path and run:

&#x20; ```powershell

&#x20; Get-ChildItem -Path .\\qf -Recurse -Include \*.jpg,\*.jpeg,\*.png -File

&#x20; ```



\- \*\*Avoid overwriting\*\*  

&#x20; If you want to skip files already present in the output folder, run a modified loop that checks `Test-Path` before calling `magick`.



\- \*\*Multiple sizes for responsive images\*\*  

&#x20; To generate multiple sizes for `srcset`, run the crop script multiple times with different `-Width`/`-Height` values and store outputs in separate folders (e.g., `qf\_400`, `qf\_800`, `qf\_1200`).



\- \*\*Performance\*\*  

&#x20; Processing many large images can be CPU and disk intensive. Consider batching or running on a machine with sufficient resources.



\- \*\*Backup originals\*\*  

&#x20; Always keep a copy of original images before bulk processing.



\#### Example Quick Commands

\*\*Open output folder\*\*

```powershell

ii .\\qf\_resized1

```



\*\*List resized files\*\*

```powershell

Get-ChildItem .\\qf\_resized2 -Recurse | Select-Object FullName,Length

```



\*\*Replace HTML references to resized folder\*\*

```powershell

Get-ChildItem -Path . -Filter \*.html -Recurse | ForEach-Object {

&#x20; (Get-Content $\_.FullName) -replace 'assets/qf/', 'assets/qf\_resized/' | Set-Content $\_.FullName

}

```



\---



\*\*License\*\*  

Use these scripts freely for personal or project use. Modify parameters to suit your workflow.

