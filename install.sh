#!/usr/bin/env bash
# ==========================================
#  🦇 GHOST TV - INSTALADOR AUTOMATICO
# ==========================================
# USO:
#   bash <(curl -sL https://github.com/Agro-bot2026/ghosttv/raw/main/install.sh)
# ==========================================

set -e
VERDE='\033[0;32m'
ROJO='\033[0;31m'
AMARILLO='\033[1;33m'
RESET='\033[0m'

echo ""
echo -e "${ROJO}╔══════════════════════════════════════╗${RESET}"
echo -e "${ROJO}║        👻  GHOST TV INSTALLER       ║${RESET}"
echo -e "${ROJO}╚══════════════════════════════════════╝${RESET}"
echo ""

# Detectar sistema
if [ ! -f /etc/os-release ]; then
    echo -e "${ROJO}⚠️  Sistema no soportado${RESET}"
    exit 1
fi

. /etc/os-release
echo -e "📌 Sistema: ${AMARILLO}$ID $VERSION_ID${RESET}"
echo ""

# ─── 1. Instalar dependencias ───
echo -e "${VERDE}[1/5] Instalando dependencias del sistema...${RESET}"

if command -v apt &>/dev/null; then
    apt update -qq && apt install -y -qq curl wget git openjdk-17-jdk unzip 2>/dev/null
elif command -v yum &>/dev/null; then
    yum install -y -q curl wget git java-17-openjdk unzip 2>/dev/null
elif command -v apk &>/dev/null; then
    apk add --no-cache curl wget git openjdk17 unzip 2>/dev/null
else
    echo -e "${ROJO}⚠️  No se pudo instalar dependencias (gestor no detectado)${RESET}"
fi

# ─── 2. Verificar Java ───
echo -e "${VERDE}[2/5] Verificando Java...${RESET}"
if command -v java &>/dev/null; then
    echo -e "   ✅ Java $(java -version 2>&1 | head -1)"
else
    echo -e "${ROJO}⚠️  Java no instalado. Instalá openjdk-17-jdk${RESET}"
fi

# ─── 3. Clonar repositorio ───
echo -e "${VERDE}[3/5] Clonando Ghost TV...${RESET}"
if [ -d "/root/ghosttv" ]; then
    echo -e "   📁 Ya existe /root/ghosttv, actualizando..."
    cd /root/ghosttv && git pull 2>/dev/null || true
else
    cd /root
    git clone https://github.com/Agro-bot2026/ghosttv.git 2>&1 | tail -1
    echo -e "   ✅ Repositorio clonado"
fi

# ─── 4. Instalar SDK Android ───
echo -e "${VERDE}[4/5] Instalando Android SDK...${RESET}"
if [ ! -d "/root/android-sdk" ]; then
    mkdir -p /root/android-sdk
    cd /root/android-sdk
    curl -sL "https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip" -o cmdline-tools.zip
    unzip -q cmdline-tools.zip
    mkdir -p cmdline-tools/latest
    mv cmdline-tools/* cmdline-tools/latest/ 2>/dev/null || true
    export ANDROID_HOME=/root/android-sdk
    export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
    yes | sdkmanager --licenses >/dev/null 2>&1 || true
    sdkmanager "platforms;android-34" "build-tools;34.0.0" >/dev/null 2>&1 || true
    echo -e "   ✅ Android SDK instalado"
else
    echo -e "   ✅ Android SDK ya existe"
fi

# ─── 5. Compilar APK ───
echo -e "${VERDE}[5/5] Compilando APK...${RESET}"
cd /root/ghosttv
export ANDROID_HOME=/root/android-sdk

# Gradle wrapper
if [ ! -f "gradlew" ]; then
    curl -sL "https://services.gradle.org/distributions/gradle-8.5-bin.zip" -o /tmp/gradle.zip
    unzip -q /tmp/gradle.zip -d /tmp/gradle
    /tmp/gradle/gradle-8.5/bin/gradle wrapper --gradle-version 8.5 2>/dev/null || true
fi

chmod +x gradlew 2>/dev/null || true
./gradlew assembleDebug 2>&1 | tail -5 || {
    echo -e "${ROJO}⚠️  Error de compilación. Probá con: cd /root/ghosttv && ./gradlew assembleDebug${RESET}"
}

APK=$(find /root/ghosttv -name "*.apk" 2>/dev/null | head -1)
if [ -f "$APK" ]; then
    cp "$APK" /root/GhostTV.apk
    echo ""
    echo -e "${VERDE}══════════════════════════════════════${RESET}"
    echo -e "${VERDE}   ✅  GHOST TV APK LISTO!${RESET}"
    echo -e "${VERDE}   📁  /root/GhostTV.apk${RESET}"
    SIZE=$(du -h /root/GhostTV.apk | cut -f1)
    echo -e "${VERDE}   📦  $SIZE${RESET}"
    echo -e "${VERDE}══════════════════════════════════════${RESET}"
else
    echo ""
    echo -e "${ROJO}⚠️  No se encontró el APK compilado.${RESET}"
    echo -e "${AMARILLO}   Revisá los errores con: cd /root/ghosttv && ./gradlew assembleDebug${RESET}"
fi
