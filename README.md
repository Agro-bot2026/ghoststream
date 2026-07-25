<div align="center">
<br>
<img src="https://raw.githubusercontent.com/Agro-bot2026/ghosttv/main/app/src/main/assets/MenuHamburguesa.png" width="280" alt="Ghost TV">
<br><br>

# 👻 GHOST TV

**IPTV Player - Android TV / Mobile**  
*Más de 2.600 canales en vivo de todo el mundo*

[![Build](https://github.com/Agro-bot2026/ghosttv/actions/workflows/build.yml/badge.svg)](https://github.com/Agro-bot2026/ghosttv/actions)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![APK](https://img.shields.io/badge/download-APK-red.svg)](#-descarga)

</div>

---

## 📱 Capturas

| Splash | Canales | Menú | Reproductor |
|--------|---------|------|-------------|
| ![Splash](https://raw.githubusercontent.com/Agro-bot2026/ghosttv/main/app/src/main/assets/Bienvenida.png) | Grid 3 columnas con logos | Menú hamburguesa con categorías | Video HLS fullscreen |

---

## ✨ Características

- 🎬 **Splash personalizado** con imagen de bienvenida
- 🔘 **Botón "INGRESAR"** - carga bajo demanda (no consume datos hasta que tocas)
- 🍔 **Menú hamburguesa** con 27 categorías y países
- 🇦🇷 **Argentina por defecto** al iniciar
- 📱 **2.659 canales** organizados por categoría y país
- 🖼️ **Logos** de cada canal
- 🔍 **Buscador** global por nombre
- 🎥 **Reproductor HLS** con soporte para streams en vivo
- 🌙 **Tema oscuro** premium
- 📺 **Compatible con Android TV** (Leanback)
- ⚡ **Ligero** - APK de solo 7.2 MB

---

## 📦 Descarga

### Opción 1: GitHub Actions (recomendado)

1. Abrí [GitHub Actions](https://github.com/Agro-bot2026/ghosttv/actions)
2. Hacé clic en el último workflow ✅ exitoso
3. Bajá el artifact `GhostTV-APK`
4. Descomprimí e instalá el `.apk`

### Opción 2: Compilar localmente

```bash
git clone https://github.com/Agro-bot2026/ghosttv.git
cd ghosttv
chmod +x gradlew
./gradlew assembleDebug
# APK en app/build/outputs/apk/debug/
```

### Opción 3: Instalador automático

```bash
bash <(curl -sL https://github.com/Agro-bot2026/ghosttv/raw/main/install.sh)
```

---

## 🗂️ Canales incluidos

Los canales provienen de [iptv-org](https://github.com/iptv-org/iptv):
- **Latinoamérica**: Argentina, México, Colombia, Chile, Perú, Venezuela, etc.
- **Europa**: España, etc.
- **Categorías**: General, Noticias, Deportes, Entretenimiento, Música, Cine, Infantil, Series, Documentales, Educación, Religioso, Cultural, etc.

> ⚠️ La disponibilidad de los canales depende de las fuentes originales.  
> Los streams se actualizan automáticamente desde iptv-org al generar el APK.

---

## 🛠️ Desarrollo

```bash
# Clonar
git clone https://github.com/Agro-bot2026/ghosttv.git
cd ghosttv

# Estructura
ghosttv/
├── app/
│   ├── src/
│   │   ├── main/
│   │   │   ├── assets/
│   │   │   │   ├── index.html       # App principal
│   │   │   │   ├── Bienvenida.png   # Splash
│   │   │   │   └── MenuHamburguesa.png # Logo
│   │   │   ├── java/com/ghosttv/
│   │   │   │   └── MainActivity.kt  # WebView wrapper
│   │   │   ├── res/
│   │   │   └── AndroidManifest.xml
│   │   └── build.gradle.kts
│   ├── build.gradle.kts
│   └── settings.gradle.kts
└── .github/workflows/build.yml      # GitHub Actions
```

---

## 🔄 Actualizar canales

Para regenerar el APK con los últimos streams disponibles:

1. El build de GitHub Actions usa los datos más recientes de iptv-org automáticamente
2. Solo hacé un push a `main` o ejecutá manualmente el workflow

---

## 📄 Licencia

MIT - Podés modificar, distribuir y vender libremente.

---

<div align="center">
<b>Ghost TV</b> — <i>by @CharlyTricks</i>
</div>
