const fs = require('fs');
const path = require('path');

// Resolve file path
const filePath = path.resolve(__dirname, "quraner-fariwala.json");

// Read file as raw string
let raw = fs.readFileSync(filePath, "utf-8");

// Trim whitespace
raw = raw.trim();

// Remove BOM if exists
if (raw.charCodeAt(0) === 0xFEFF) {
  raw = raw.slice(1);
}

// Parse JSON safely
const data = JSON.parse(raw);

// Save pretty JSON
const outputPath = path.resolve(__dirname, "quraner-fariwala-copy.json");
fs.writeFileSync(outputPath, JSON.stringify(data, null, 2), "utf-8");

console.log("✅ JSON reformatted and saved as quraner-fariwala-copy.json");
