#!/bin/bash

# 1. Pastikan direktori Wine dan mount path ada dengan permission terbuka
mkdir -p /config/.wine/drive_c
chmod -R 777 /config

# 2. Jalankan Virtual Display (Xvfb) & Window Manager (Openbox)
Xvfb :1 -screen 0 1280x1024x24 &
sleep 2
openbox &

# 3. Jalankan VNC Server & noVNC Web Client
x11vnc -display :1 -forever -shared -rfbport 5900 -nopw &
/usr/share/novnc/utils/novnc_proxy --vnc localhost:5900 --listen 8080 &

# 4. Matikan prompt Wine Mono / Gecko installer agar tidak stuck
export WINEDLLOVERRIDES="mscoree=d;mshtml=d"

# 5. Cek apakah MT5 sudah terinstall
MT5_PATH="/config/.wine/drive_c/Program Files/MetaTrader 5/terminal64.exe"

if [ ! -f "$MT5_PATH" ]; then
    echo "[INFO] MetaTrader 5 belum terinstall. Mendownload installer..."
    curl -sL https://download.mql5.com/cdn/web/metaquotes.software.corp/mt5/mt5setup.exe -o /config/mt5setup.exe
    
    echo "[INFO] Menginstall MetaTrader 5..."
    wine /config/mt5setup.exe /auto
    sleep 10
fi

echo "[INFO] Memulai MetaTrader 5..."
wine "$MT5_PATH"
