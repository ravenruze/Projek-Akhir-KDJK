#!/bin/bash
set -e

echo "=== [1/4] Memperbarui Sistem ==="
sudo apt update -y && sudo apt install -y curl

echo "=== [2/4] Memeriksa Instalasi Docker ==="
if ! command -v docker &> /dev/null; then
    echo "Docker belum terpasang. Memulai instalasi Docker..."
    curl -fsSL [https://get.docker.com](https://get.docker.com) | sh
fi

echo "=== [3/4] Menyiapkan Direktori Data Memos ==="
mkdir -p ~/.memos

echo "=== [4/4] Menjalankan Container Memos ==="
docker run -d \
  --name memos \
  --restart unless-stopped \
  -p 5230:5230 \
  -v ~/.memos:/var/opt/memos \
  neosmemo/memos:stable

echo "=== SELESAI! Aplikasi Memos berhasil berjalan di http://$(curl -s ifconfig.me):5230 ==="
