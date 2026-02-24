# Target qualities (height in pixels)
$qualities = @(
    @{ name = "720p"; height = 720 },
    @{ name = "1080p"; height = 1080 }
)

# Supported video extensions
$extensions = "*.mp4","*.mkv","*.mov","*.avi","*.webm"

foreach ($q in $qualities) {

    $qualityName = $q.name
    $targetHeight = $q.height
    $outputDir = "compressed_videos/$qualityName"

    # Create output folder if it doesn't exist
    if (!(Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir | Out-Null
    }

    foreach ($ext in $extensions) {
        Get-ChildItem -Path . -Filter $ext | ForEach-Object {

            $input = $_.FullName
            $output = Join-Path $outputDir $_.Name

            # Get video height
            $height = & ffprobe -v error `
                -select_streams v:0 `
                -show_entries stream=height `
                -of csv=p=0 "$input"

            if ([int]$height -gt $targetHeight) {
                Write-Host "Compressing $($_.Name) ($height p → $qualityName)"

                ffmpeg -y -i "$input" `
                    -vf "scale=-2:$targetHeight" `
                    -c:v libx264 `
                    -preset medium `
                    -crf 23 `
                    -movflags +faststart `
                    "$output"
            }
            else {
                Write-Host "Skipping $($_.Name) (≤ $qualityName)"
            }
        }
    }
}

Write-Host "All done."
