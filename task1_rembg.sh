#!/bin/bash
cd "$(dirname "$0")"
export PATH="$HOME/.local/bin:$PATH"
rembg i public/images/lianahanelle-7.jpg public/images/hero-cutout.png
echo "rembg exit code: $?"
ls -la public/images/hero-cutout.png
