#!/data/data/com.termux/files/usr/bin/bash

echo "[+] Updating packages..."
pkg update -y && pkg upgrade -y

echo "[+] Installing dependencies..."
pkg install git cmake clang make wget -y

echo "[+] Cloning llama.cpp..."
git clone https://github.com/ggerganov/llama.cpp ~/llama.cpp

cd ~/llama.cpp || exit

echo "[+] Building..."
cmake -B build
cmake --build build --config Release

mkdir -p ~/llama.cpp/models
cd ~/dolphin-termux || exit

bash detect.sh
MODEL=$(cat model_choice.txt)

echo "[+] Selected model: $MODEL"

cd ~/llama.cpp/models || exit

BASE_URL="https://huggingface.co/TheBloke/dolphin-2.6-mistral-7B-GGUF/resolve/main"

wget -O dolphin.gguf $BASE_URL/dolphin-2.6-mistral-7b.$MODEL.gguf

echo "[+] Installing launcher command..."
cp ~/dolphin-termux/dolphin.sh $PREFIX/bin/dolphin
chmod +x $PREFIX/bin/dolphin

echo "[✓] Install complete"
echo "Run with: dolphin"
