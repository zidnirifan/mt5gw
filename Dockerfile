FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV WINEPREFIX=/config/.wine
ENV DISPLAY=:1

# Aktifkan i386 dan install dependensi
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
    xvfb \
    x11vnc \
    openbox \
    wine \
    wine32 \
    wine64 \
    novnc \
    websockify \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Salin script pemula ke /usr/local/bin agar TIDAK tertimpa oleh Railway Volume
COPY start.sh /usr/local/bin/start.sh

# Konversi CRLF ke LF dan beri izin eksekusi
RUN sed -i 's/\r$//' /usr/local/bin/start.sh && chmod +x /usr/local/bin/start.sh

WORKDIR /config

EXPOSE 8080

CMD ["/usr/local/bin/start.sh"]
