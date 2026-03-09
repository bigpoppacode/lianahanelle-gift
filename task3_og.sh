#!/bin/bash
cd "$(dirname "$0")"
FONT="/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf"
ffmpeg -y \
  -f lavfi -i "color=c=0x08080A:s=1280x720:d=1" \
  -i public/images/hero-cutout.png \
  -filter_complex "
    [1:v]scale=-1:620[cutout];
    [0:v][cutout]overlay=W-w-60:(H-h)/2[bg];
    [bg]drawtext=fontfile=${FONT}:text='LIANA HANELLE':fontcolor=0x2ECC71:fontsize=72:x=80:y=260[t1];
    [t1]drawbox=x=80:y=350:w=400:h=3:color=0x2ECC71@1:t=fill[line];
    [line]drawtext=fontfile=${FONT}:text='Soul  \\xC2\\xB7  Spirit  \\xC2\\xB7  Alignment':fontcolor=0x8A8A94:fontsize=28:x=80:y=375
  " \
  -frames:v 1 \
  public/images/og-image.png
echo "ffmpeg og exit code: $?"
ls -la public/images/og-image.png
