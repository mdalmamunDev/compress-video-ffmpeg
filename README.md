# Video Compression Script

This repository contains a simple PowerShell script (`compress.ps1`) that uses `ffmpeg` and `ffprobe` to downscale and compress videos.

## Features

- Targets two qualities: **720p** and **1080p**
- Supports common video formats (`.mp4`, `.mkv`, `.mov`, `.avi`, `.webm`)
- Skips files already at or below the target height
- Outputs compressed files to `compressed_videos/720p` and `compressed_videos/1080p` directories

## Requirements

- Windows PowerShell
- [FFmpeg](https://ffmpeg.org/) installed and available in your PATH (includes `ffprobe`)

## Usage

1. Place `compress.ps1` in the folder containing the videos you want to process.
2. Open PowerShell and navigate to that folder.
3. Run the script:
   ```powershell
   ./compress.ps1
   ```
4. Compressed videos will appear in the corresponding subfolders.

## Notes

- You can add or change target qualities by editing the `$qualities` array in the script.
- The script preserves the original filenames and only recompresses videos with greater height than the target.

---

Feel free to modify the script to suit your needs!