FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV WINEPREFIX=/config/.wine
ENV DISPLAY=:1

# 1. Aktifkan arsitektur i386 TERLEBIH DAHULU sebelum apt-get update
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

WORKDIR /config

# Salin script pemula
COPY start.sh /config/start.sh
RUN chmod +x /config/start.sh

EXPOSE 8080

CMD ["/config/start.sh"]
