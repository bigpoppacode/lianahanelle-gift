from rembg import remove
from PIL import Image
import os

input_path = "public/images/lianahanelle-7.jpg"
output_path = "public/images/hero-cutout.png"

with open(input_path, "rb") as f:
    input_data = f.read()

output_data = remove(input_data)

with open(output_path, "wb") as f:
    f.write(output_data)

print(f"Done: {output_path} ({os.path.getsize(output_path)} bytes)")
