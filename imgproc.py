import importlib, os

mod = importlib.import_module("rembg")
remove_fn = getattr(mod, "remove")

with open("public/images/lianahanelle-7.jpg", "rb") as f:
    data = f.read()

result = remove_fn(data)

with open("public/images/hero-cutout.png", "wb") as f:
    f.write(result)

print(f"Output: {os.path.getsize('public/images/hero-cutout.png')} bytes")
