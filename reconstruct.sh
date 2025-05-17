#!/bin/bash

# Configuration
OUTPUT_FILE="P52574_001_spp-Gen9.1-Gen9SPPGen91.2022_0822.4_2_reconstructed.iso"
CHUNKS_DIR="./split_parts"
CHUNK_PREFIX="spp_chunk_"
EXPECTED_HASH="CBD7A2A1D1AA4BBAD95797DD281ACF89910F9054D36D78857EE3E8C5FE625790"

# Remove old output if it exists
[ -f "$OUTPUT_FILE" ] && rm "$OUTPUT_FILE"

echo "Reconstructing ISO from chunks in: $CHUNKS_DIR"

# Concatenate chunks in order
for chunk in $(ls "$CHUNKS_DIR"/$CHUNK_PREFIX* | sort); do
    echo "Adding $chunk"
    cat "$chunk" >> "$OUTPUT_FILE"
done

echo ""
echo "Reconstruction complete: $OUTPUT_FILE"

# Compute SHA256 checksum
echo "Computing SHA256 checksum..."
ACTUAL_HASH=$(sha256sum "$OUTPUT_FILE" | awk '{ print toupper($1) }')

echo "Actual Hash:   $ACTUAL_HASH"
echo "Expected Hash: $EXPECTED_HASH"

# Compare checksums
if [[ "$ACTUAL_HASH" == "$EXPECTED_HASH" ]]; then
    echo -e "\n✅ Hash MATCHES expected value."
else
    echo -e "\n❌ Hash DOES NOT match expected value!"
fi
