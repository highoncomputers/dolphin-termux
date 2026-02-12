#!/data/data/com.termux/files/usr/bin/bash

MODEL=~/llama.cpp/models/dolphin.gguf
BIN=~/llama.cpp/build/bin/llama-cli
PROMPT=~/dolphin-termux/prompt.txt

THREADS=$(nproc)

$BIN -m $MODEL \
-t $THREADS \
-c 2048 \
-n 512 \
--file $PROMPT \
--temp 0.8 \
--top-p 0.95
