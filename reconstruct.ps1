$outFile = ".\P52574_001_spp-Gen9.1-Gen9SPPGen91.2022_0822.4_2_reconstructed.iso"
$inDir = ".\split_parts"
$chunkPattern = "spp_chunk_*"
$expectedHash = "CBD7A2A1D1AA4BBAD95797DD281ACF89910F9054D36D78857EE3E8C5FE625790"

$resolvedInDir = (Resolve-Path $inDir).Path
$resolvedOutFile = (Resolve-Path -Path "." -ErrorAction Stop).Path + "\" + (Split-Path $outFile -Leaf)

# Delete existing output if it exists
if (Test-Path $resolvedOutFile) {
    Remove-Item $resolvedOutFile
}

# Get all chunk files in order
$chunkFiles = Get-ChildItem -Path $resolvedInDir -Filter $chunkPattern | Sort-Object Name

# Open output file stream
$outStream = [System.IO.File]::OpenWrite($resolvedOutFile)

foreach ($chunk in $chunkFiles) {
    $chunkPath = $chunk.FullName
    Write-Host "Merging: $chunkPath"
    $inBytes = [System.IO.File]::ReadAllBytes($chunkPath)
    $outStream.Write($inBytes, 0, $inBytes.Length)
}

$outStream.Close()
Write-Host "`nReconstructed ISO saved to: $resolvedOutFile"

# Compute SHA256 hash using .NET (compatible with all PowerShell versions)
Add-Type -AssemblyName System.Security
$sha256 = [System.Security.Cryptography.SHA256]::Create()
$fileStream = [System.IO.File]::OpenRead($resolvedOutFile)
$hashBytes = $sha256.ComputeHash($fileStream)
$fileStream.Close()
$hashString = (-join ($hashBytes | ForEach-Object { "{0:x2}" -f $_ })).ToUpper()

Write-Host "`nSHA256 Checksum: $hashString"

# Compare with expected hash
if ($hashString -eq $expectedHash) {
    Write-Host "`nHash MATCHES expected value." -ForegroundColor Green
} else {
    Write-Host "`nHash DOES NOT match expected value." -ForegroundColor Red
}