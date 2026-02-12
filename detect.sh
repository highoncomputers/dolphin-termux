#!/data/data/com.termux/files/usr/bin/bash

RAM=$(free -m | awk '/Mem:/ {print $2}')

if [ "$RAM" -lt 5000 ]; then
MODEL="Q3_K_S"
elif [ "$RAM" -lt 8000 ]; then
MODEL="Q4_K_S"
else
MODEL="Q4_K_M"
fi

echo $MODEL > model_choice.txt
