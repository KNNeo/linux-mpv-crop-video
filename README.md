# mpv-crop-video for Linux
Creates cropped video segment using mpv hotkeys

This script only works in Linux, tested on Zorin OS 17.1. 

## Dependencies
- mpv
- kdialog
- ffmpeg
Install before usage:
```
sudo apt install ffmpeg kdialog mpv
```

## Installation
- Install dependencies (see above)
- Place `mpv-crop.lua` in `$HOME/.config/{mpv-based_video_player_of_choice}/scripts` (tested on mpv, celluloid)
- Restart player

## Hotkeys

* `Ctrl+[` - Start time
* `Ctrl+]` - End time
* `CTRL+c` - Export video



