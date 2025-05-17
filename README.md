# HPE ProLiant ML110 Gen9 BIOS ROM 3.40_08_29_2 + iLO4

This repository contains the BIOS ROM version 3.40_08_29_2 and iLO4 firmware for the HPE ProLiant ML110 Gen9 server.

HPE no longer provides these updates unless the server is under an active warranty or a support contract. Unfortunately, that leaves users either paying for firmware they’ve already licensed or hunting down overpriced listings on places like eBay.

Since the ML110 Gen9 is now considered a legacy product, this repo is here to help users access the updates they need — without jumping through unnecessary hoops or paying ridiculous fees for basic functionality.

---

## About the SPP ISO

The SPP ISO file was too large to upload directly due to GitHub’s 2GB per-file push limit (even with Git LFS), so it's been split into chunks and stored in the `split_parts/` folder.

You can reconstruct the full ISO using the included scripts, depending on your operating system:

---

## 🔧 Reconstructing the ISO (P52574_001_spp-Gen9.1-Gen9SPPGen91.2022_0822.4.iso)

### On Windows:

First, run a Powershell terminal and make sure scripts are allowed to run:

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

Then run:

```powershell
.\reconstruct.ps1
```

### On Linux/macOS:

Make the script executable and run:

```bash
chmod +x reconstruct.sh
./reconstruct.sh
```

---

## ✅ Checksum Verification

After reconstruction, the ISO file should match the following SHA256 hash:

```
CBD7A2A1D1AA4BBAD95797DD281ACF89910F9054D36D78857EE3E8C5FE625790
```

If the hash matches, you're good to go.

---

## 📁 Files Included

- `split_parts/` — Split parts of the original SPP ISO
- `split.ps1` — Script to split the ISO (FYI)
- `reconstruct.ps1` — Windows PowerShell script to reassemble the ISO
- `reconstruct.sh` — Bash script to reassemble the ISO on Linux/macOS

---

Feel free to contribute or mirror this repo elsewhere in case HPE makes access even more difficult.