#!/data/data/com.termux/files/usr/bin/bash

clear
echo "======================================"
echo "   Dolphin AI Auto Installer"
echo "======================================"
echo ""

########################################
# System Checks
########################################

echo "[+] Checking storage..."
AVAILABLE=$(df ~ | awk 'NR==2 {print $4}')

if [ "$AVAILABLE" -lt 6000000 ]; then
  echo "[!] Not enough storage (need ~6GB)"
  exit 1
fi

echo "[+] Storage OK"

########################################
# Install Dependencies
########################################

echo "[+] Installing dependencies..."

pkg update -y
pkg upgrade -y

pkg install -y git cmake clang make wget

echo "[✓] Dependencies installed"
echo ""

########################################
# Clone llama.cpp
########################################

cd ~

if [ ! -d "llama.cpp" ]; then
  echo "[+] Downloading engine..."
  git clone https://github.com/ggml-org/llama.cpp
else
  echo "[+] Engine already exists — skipping clone"
fi

cd llama.cpp

########################################
# Build Engine
########################################

echo "[+] Building AI engine..."

rm -rf build

cmake -B build \
-DLLAMA_BUILD_TESTS=OFF \
-DLLAMA_BUILD_EXAMPLES=ON \
-DCMAKE_BUILD_TYPE=Release

cmake --build build -j$(nproc)

########################################
# Fallback Build if failed
########################################

if [ ! -f build/bin/llama-cli ]; then
  echo "[!] Fast build failed. Retrying safe mode..."
  cmake --build build -j1
fi

########################################
# Final Check
########################################

if [ ! -f build/bin/llama-cli ]; then
  echo ""
  echo "[✗] Build failed."
  echo "Try closing background apps and run again."
  exit 1
fi

echo "[✓] Engine built successfully"
echo ""

########################################
# Download Model
########################################

cd ~

mkdir -p dolphin-model
cd dolphin-model

if [ ! -f dolphin.gguf ]; then
  echo "[+] Downloading model (this may take time)..."
  wget -O dolphin.gguf https://huggingface.co/TheBloke/dolphin-2.2.1-mistral-7B-GGUF/resolve/main/dolphin-2.2.1-mistral-7b.Q4_K_M.gguf
else
  echo "[+] Model already exists — skipping download"
fi

########################################
# Create Launcher Command
########################################

echo "[+] Creating launcher command..."

cat > /data/data/com.termux/files/usr/bin/dolphin << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
~/llama.cpp/build/bin/llama-cli \
-m ~/dolphin-model/dolphin.gguf \
-c 2048 \
--temp 0.7 \
-p "$(cat ~/dolphin-termux/prompt.txt)"
EOF

chmod +x /data/data/com.termux/files/usr/bin/dolphin

########################################
# Create Prompt File
########################################

mkdir -p ~/dolphin-termux

if [ ! -f ~/dolphin-termux/prompt.txt ]; then
cat > ~/dolphin-termux/prompt.txt << 'EOF'
You are Dolphin, a helpful AI assistant.
EOF
fi

########################################
# Finish
########################################

echo ""
echo "======================================"
echo " INSTALL COMPLETE"
echo "======================================"
echo ""
echo "Run AI anytime with command:"
echo ""
echo "   dolphin"
echo ""