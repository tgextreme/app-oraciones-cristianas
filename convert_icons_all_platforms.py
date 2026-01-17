from PIL import Image
import os

# Abrir la imagen PNG original
img = Image.open('assets/images/ico.png')

# Asegurarse de que la imagen tiene canal alfa (transparencia)
if img.mode != 'RGBA':
    img = img.convert('RGBA')

print(f"✓ Imagen cargada: {img.size}, Modo: {img.mode}")

# LINUX - Iconos PNG en diferentes tamaños
linux_icon_dir = 'linux/runner/resources'
os.makedirs(linux_icon_dir, exist_ok=True)

linux_sizes = [512, 256, 128, 64, 48, 32, 16]
for size in linux_sizes:
    resized = img.resize((size, size), Image.Resampling.LANCZOS)
    output_path = os.path.join(linux_icon_dir, f'app_icon_{size}.png')
    resized.save(output_path, 'PNG')
    print(f"✓ Linux: {output_path}")

# ANDROID - Iconos en carpetas mipmap
android_icon_configs = [
    ('mipmap-mdpi', 48),
    ('mipmap-hdpi', 72),
    ('mipmap-xhdpi', 96),
    ('mipmap-xxhdpi', 144),
    ('mipmap-xxxhdpi', 192),
]

for folder, size in android_icon_configs:
    android_dir = f'android/app/src/main/res/{folder}'
    os.makedirs(android_dir, exist_ok=True)
    
    resized = img.resize((size, size), Image.Resampling.LANCZOS)
    output_path = os.path.join(android_dir, 'ic_launcher.png')
    resized.save(output_path, 'PNG')
    print(f"✓ Android: {output_path}")

print("\n✓ Todos los iconos generados exitosamente para Linux y Android")
