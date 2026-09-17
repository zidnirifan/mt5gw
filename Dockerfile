FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV WINEPREFIX=/config/.wine
ENV DISPLAY=:1

# Install dependencies yang dibutuhkan (Wine, VNC, noVNC, XVFB, Curl)
RUN apt-get update && apt-get install -y \
    xvfb \
    x11vnc \
    openbox \
    wine64 \
    wine32 \
    novnc \
    websockify \
    curl \
    ca-certificates \
    && dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y wine32 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /config

# Salin script pemula
COPY start.sh /config/start.sh
RUN chmod +x /config/start.sh

# Port default untuk noVNC (Railway akan mengarahkan trafik ke port ini)
EXPOSE 8080

CMD ["/config/start.sh"]
