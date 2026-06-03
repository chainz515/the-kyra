"""
Génère l'icône The Kyra et remplace les icônes Android/Flutter.
"""
import os, math
from PIL import Image, ImageDraw, ImageFilter

def make_icon(size: int) -> Image.Image:
    S = size
    img = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)

    # ── Fond vert arrondi ─────────────────────────────────────────────────────
    radius = int(S * 0.2)
    bg = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    bgd = ImageDraw.Draw(bg)
    bgd.rounded_rectangle([0, 0, S-1, S-1], radius=radius,
                           fill=(21, 64, 18, 255))
    img.paste(bg, mask=bg)

    # Dégradé vertical overlay sur fond
    grad_overlay = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    god = ImageDraw.Draw(grad_overlay)
    for y in range(S):
        alpha = int(30 * (y / S))
        god.line([(0, y), (S, y)], fill=(0, 0, 0, alpha))
    img = Image.alpha_composite(img, grad_overlay)
    d = ImageDraw.Draw(img)

    # ── Boule ──────────────────────────────────────────────────────────────────
    bx, by = S // 2, int(S * 0.42)
    br = int(S * 0.285)

    # Ombre portée
    shadow_layer = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    sd = ImageDraw.Draw(shadow_layer)
    for i in range(8):
        a = int(35 * (1 - i/8))
        ex = int(br * 1.0 + i * 2)
        ey = int(br * 0.22 + i * 1)
        sd.ellipse([bx - ex, by + int(br*0.8) - ey,
                    bx + ex, by + int(br*0.8) + ey],
                   fill=(0, 0, 0, a))
    shadow_blur = shadow_layer.filter(ImageFilter.GaussianBlur(S * 0.02))
    img = Image.alpha_composite(img, shadow_blur)
    d = ImageDraw.Draw(img)

    # Corps boule noir
    ball_layer = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    bd = ImageDraw.Draw(ball_layer)
    bd.ellipse([bx-br, by-br, bx+br, by+br], fill=(15, 15, 15, 255))
    img = Image.alpha_composite(img, ball_layer)
    d = ImageDraw.Draw(img)

    # Dégradé sphérique simulé (couches concentriques)
    for i in range(br, 0, -1):
        t = i / br
        r = int(40 * t * t)
        g = int(40 * t * t)
        b = int(40 * t * t)
        a = int(180 * (1 - t))
        offset_x = int(-br * 0.3 * (1 - t))
        offset_y = int(-br * 0.3 * (1 - t))
        d.ellipse([bx + offset_x - i, by + offset_y - i,
                   bx + offset_x + i, by + offset_y + i],
                  fill=(r, g, b, a))

    # Cercle blanc (style 8-ball)
    wr = int(br * 0.44)
    d.ellipse([bx-wr, by-wr, bx+wr, by+wr], fill=(255, 255, 255, 255))

    # ── Lettre K ───────────────────────────────────────────────────────────────
    font_size = int(br * 0.65)
    try:
        from PIL import ImageFont
        # Essaie quelques polices système Windows
        for fname in ["arialbd.ttf", "Arial Bold.ttf", "georgia.ttf", "verdanab.ttf"]:
            try:
                font = ImageFont.truetype(f"C:/Windows/Fonts/{fname}", font_size)
                break
            except Exception:
                font = ImageFont.load_default()
    except Exception:
        font = ImageFont.load_default()

    # Centrer le K
    bbox = d.textbbox((0, 0), "K", font=font)
    tw = bbox[2] - bbox[0]
    th = bbox[3] - bbox[1]
    tx = bx - tw // 2 - bbox[0]
    ty = by - th // 2 - bbox[1] + int(br * 0.02)
    d.text((tx, ty), "K", fill=(20, 20, 20, 255), font=font)

    # ── Reflet brillance ───────────────────────────────────────────────────────
    shine_layer = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    shd = ImageDraw.Draw(shine_layer)
    shine_r = int(br * 0.6)
    sx = bx - int(br * 0.28)
    sy = by - int(br * 0.28)
    for i in range(shine_r, 0, -2):
        t = i / shine_r
        a = int(110 * (1 - t) * (1 - t))
        shd.ellipse([sx-i, sy-i, sx+i, sy+i], fill=(255, 255, 255, a))
    img = Image.alpha_composite(img, shine_layer)
    d = ImageDraw.Draw(img)

    # Petit point vif
    hr = int(br * 0.07)
    hx = bx - int(br * 0.3)
    hy = by - int(br * 0.33)
    d.ellipse([hx-hr, hy-int(hr*0.65), hx+hr, hy+int(hr*0.65)],
              fill=(255, 255, 255, 200))

    # ── Texte THE KYRA ─────────────────────────────────────────────────────────
    text_size = int(S * 0.09)
    try:
        for fname in ["arialbd.ttf", "Arial Bold.ttf", "verdanab.ttf", "calibrib.ttf"]:
            try:
                tfont = ImageFont.truetype(f"C:/Windows/Fonts/{fname}", text_size)
                break
            except Exception:
                tfont = ImageFont.load_default()
    except Exception:
        tfont = ImageFont.load_default()

    label = "THE KYRA"
    tbbox = d.textbbox((0, 0), label, font=tfont)
    tw2 = tbbox[2] - tbbox[0]
    tx2 = (S - tw2) // 2 - tbbox[0]
    ty2 = int(S * 0.845) - (tbbox[3] - tbbox[1]) - tbbox[1]

    # Ombre texte
    d.text((tx2+2, ty2+3), label, font=tfont, fill=(0, 0, 0, 120))
    # Texte blanc
    d.text((tx2, ty2), label, font=tfont, fill=(255, 255, 255, 255))

    # Ligne décorative
    line_y = int(S * 0.875)
    line_w = int(S * 0.35)
    lx0 = S//2 - line_w//2
    lx1 = S//2 + line_w//2
    for i, lx in enumerate(range(lx0, lx1)):
        t = abs(lx - S//2) / (line_w//2)
        a = int(140 * (1 - t*t))
        d.point((lx, line_y), fill=(255, 255, 255, a))

    # ── Bordure intérieure fine ────────────────────────────────────────────────
    margin = int(S * 0.025)
    inner_r = int(S * 0.175)
    d.rounded_rectangle([margin, margin, S-margin, S-margin],
                         radius=inner_r, outline=(255, 255, 255, 25), width=2)

    return img


def replace_android_icons(base_img: Image.Image, project_root: str):
    """Remplace toutes les icônes Android dans le projet Flutter."""
    sizes = {
        "mipmap-mdpi":    48,
        "mipmap-hdpi":    72,
        "mipmap-xhdpi":   96,
        "mipmap-xxhdpi":  144,
        "mipmap-xxxhdpi": 192,
    }
    res_dir = os.path.join(project_root, "android", "app", "src", "main", "res")

    for folder, size in sizes.items():
        out_dir = os.path.join(res_dir, folder)
        os.makedirs(out_dir, exist_ok=True)
        icon = base_img.resize((size, size), Image.LANCZOS)
        # ic_launcher.png (avec fond)
        flat = Image.new("RGB", (size, size), (21, 64, 18))
        flat.paste(icon, mask=icon.split()[3])
        flat.save(os.path.join(out_dir, "ic_launcher.png"))
        print(f"  OK {folder}/ic_launcher.png  ({size}x{size})")

    # Sauvegarde aussi en 1024 pour flutter_launcher_icons futur
    big = base_img.resize((1024, 1024), Image.LANCZOS)
    assets_dir = os.path.join(project_root, "assets", "icon")
    os.makedirs(assets_dir, exist_ok=True)
    big.save(os.path.join(assets_dir, "icon.png"))
    print(f"  OK assets/icon/icon.png  (1024x1024)")


if __name__ == "__main__":
    root = r"c:\Users\heros\OneDrive\Documents\the kira"
    print("Génération de l'icône The Kyra...")
    base = make_icon(1024)
    print("Remplacement des icônes Android...")
    replace_android_icons(base, root)
    print("\nTerminé ! Rebuild l'APK pour appliquer la nouvelle icône.")
