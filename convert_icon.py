from PIL import Image
import os

# Abrir la imagen PNG
img = Image.open('assets/images/ico.png')

# Asegurarse de que la imagen tiene canal alfa (transparencia)
if img.mode != 'RGBA':
    img = img.convert('RGBA')

# Crear el archivo ICO con múltiples tamaños
sizes = [(256, 256), (128, 128), (64, 64), (48, 48), (32, 32), (16, 16)]
output_path = 'windows/runner/resources/app_icon.ico'

# Guardar como ICO con múltiples tamaños
img.save(output_path, format='ICO', sizes=sizes)

print(f"✓ Icono convertido exitosamente: {output_path}")
print(f"  Tamaño original: {img.size}")
print(f"  Modo: {img.mode}")
print(f"  Tamaños incluidos: {sizes}")
