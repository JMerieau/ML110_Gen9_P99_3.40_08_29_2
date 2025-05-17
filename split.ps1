# Configuration
$chunkSize = 90MB
$inFile = ".\P52574_001_spp-Gen9.1-Gen9SPPGen91.2022_0822.4.iso"
$outDir = ".\split_parts"
$baseName = "spp_chunk_"
$chunkPattern = "$baseName*"

# Resolve absolute paths
$resolvedInFile = (Resolve-Path $inFile).Path
$resolvedOutDir = (Resolve-Path -Path $outDir -ErrorAction SilentlyContinue)

# Create or clean output directory
if (-not $resolvedOutDir) {
    New-Item -ItemType Directory -Path $outDir | Out-Null
    $resolvedOutDir = (Resolve-Path $outDir).Path
} else {
    Write-Host "Cleaning existing split_parts folder..."
    Get-ChildItem -Path $resolvedOutDir -Filter $chunkPattern | Remove-Item -Force
}

Write-Host "Input file: $resolvedInFile"
Write-Host "Output directory: $resolvedOutDir"

# Initialize read buffer and input stream
$buffer = New-Object byte[] $chunkSize
$inStream = [System.IO.File]::OpenRead($resolvedInFile)
$i = 0

# Read and write chunks
while (($read = $inStream.Read($buffer, 0, $chunkSize)) -gt 0) {
    $chunkFileName = "$baseName$('{0:D3}' -f $i)"
    $chunkFilePath = Join-Path -Path $resolvedOutDir -ChildPath $chunkFileName

    try {
        $outStream = [System.IO.File]::OpenWrite($chunkFilePath)
        $outStream.Write($buffer, 0, $read)
        $outStream.Close()
        Write-Host "Wrote: $chunkFilePath"
    }
    catch {
        Write-Error "Failed to write $chunkFilePath"
        break
    }

    $i++
}

# Cleanup
$inStream.Close()
Write-Host ""
Write-Host "Split complete: $i chunk(s) created."