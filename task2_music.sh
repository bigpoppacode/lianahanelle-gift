#!/bin/bash
cd "$(dirname "$0")"
ffmpeg -y \
  -f lavfi -i "sine=frequency=174:duration=180" \
  -f lavfi -i "sine=frequency=285:duration=180" \
  -f lavfi -i "sine=frequency=396:duration=180" \
  -f lavfi -i "sine=frequency=528:duration=180" \
  -f lavfi -i "anoisesrc=color=brown:duration=180:amplitude=0.015" \
  -filter_complex "[0:a]volume=0.08[s1];[1:a]volume=0.06[s2];[2:a]volume=0.05[s3];[3:a]volume=0.07[s4];[4:a]volume=0.3[noise];[s1][s2][s3][s4][noise]amix=inputs=5:duration=longest,afade=t=in:d=5,afade=t=out:st=175:d=5,aformat=sample_rates=44100:channel_layouts=stereo" \
  public/audio/holistic-harmony.mp3
echo "ffmpeg music exit code: $?"
ls -la public/audio/holistic-harmony.mp3
