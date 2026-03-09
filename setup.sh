#!/bin/bash
set -e
cd "$(dirname "$0")"

export PATH="$HOME/.local/bin:$PATH"

echo "🌿 Liana Hanelle Gift Site Setup"
echo "================================"
echo ""

echo "[1/6] Installing dependencies..."
npm install

echo "[2/6] Removing hero background..."
rembg i public/images/lianahanelle-7.jpg public/images/hero-cutout.png
echo "  ✓ Hero cutout created"

echo "[3/6] Generating ambient music..."
ffmpeg -y \
  -f lavfi -i "sine=frequency=174:duration=180" \
  -f lavfi -i "sine=frequency=285:duration=180" \
  -f lavfi -i "sine=frequency=396:duration=180" \
  -f lavfi -i "sine=frequency=528:duration=180" \
  -f lavfi -i "anoisesrc=color=brown:duration=180:amplitude=0.015" \
  -filter_complex "[0:a]volume=0.08[s1];[1:a]volume=0.06[s2];[2:a]volume=0.05[s3];[3:a]volume=0.07[s4];[4:a]volume=0.3[noise];[s1][s2][s3][s4][noise]amix=inputs=5:duration=longest,afade=t=in:d=5,afade=t=out:st=175:d=5,aformat=sample_rates=44100:channel_layouts=stereo" \
  public/audio/holistic-harmony.mp3 2>/dev/null
echo "  ✓ Music generated"

echo "[4/6] Creating OG image..."
FONT="/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf"
ffmpeg -y \
  -f lavfi -i "color=c=0x08080A:s=1280x720:d=1" \
  -i public/images/hero-cutout.png \
  -filter_complex "
    [1:v]scale=-1:680[photo];
    [0:v][photo]overlay=x=W-overlay_w+60:y=(H-overlay_h)/2+20[bg];
    [bg]drawtext=fontfile=${FONT}:text='LIANA':fontcolor=0x2ECC71:fontsize=100:x=70:y=200[t1];
    [t1]drawtext=fontfile=${FONT}:text='HANELLE':fontcolor=0x2ECC71:fontsize=100:x=70:y=310[t2];
    [t2]drawbox=x=70:y=430:w=360:h=2:color=0x2ECC71@0.6:t=fill[line];
    [line]drawtext=fontfile=${FONT}:text='Soul · Spirit · Alignment':fontcolor=0x8A8A94:fontsize=26:x=70:y=455[out]
  " \
  -map "[out]" -frames:v 1 -update 1 public/images/og-image.png 2>/dev/null
echo "  ✓ OG image created"

echo "[5/6] Initializing git repository..."
git init
git add -A
git commit -m "Initial build — premium dark luxury site for Liana Hanelle"
git remote add origin git@github.com:bigpoppacode/liana-hanelle-gift.git
git branch -M main
git push -u origin main
echo "  ✓ Pushed to GitHub"

echo "[6/6] Starting server..."
node server.js &
echo ""
echo "🌿 Setup complete!"
echo "   Site running at http://localhost:31003"
