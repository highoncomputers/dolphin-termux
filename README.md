🐬 Dolphin AI — Installation Guide

Run a powerful offline AI on your Android phone.
No technical knowledge needed — just copy and paste commands.

---

📱 Requirements

- Android phone
- Internet connection (first time only)
- Termux app installed

---

📥 Step 1 — Install Termux

Download Termux from F-Droid (recommended official source):

https://f-droid.org/packages/com.termux/

Open Termux after installing.

---

⬆️ Step 2 — Update Termux Packages

Copy and paste this command and press Enter:

pkg update

Wait until it finishes.

---

🔼 Step 3 — Upgrade Installed Packages

Now run:

pkg upgrade -y

This ensures your system tools are up to date.

---

🧰 Step 4 — Install Git

Git is required to download the AI files.

Run:

pkg install git -y

Wait until installation completes.

---

📦 Step 5 — Install Dolphin AI

Copy and paste this single command:

git clone https://github.com/highoncomputers/dolphin-termux && cd dolphin-termux && bash install.sh

This automatically:

- installs required tools
- builds the AI engine
- detects your phone power
- downloads best model
- sets launcher command

⏳ This step may take 5–20 minutes

---

🚀 Step 6 — Start AI

After installation finishes, type:

dolphin

Your AI will start.

---

💬 How To Chat

Type a message and press Enter.

Example:

Hello

---

🔁 Run Again Anytime

Open Termux and type:

dolphin

---

🧠 Automatic Optimization

Installer detects your phone specs and selects best model:

RAM| Model
4 GB| Light
6 GB| Balanced
8 GB+| High Quality

---

❗ Troubleshooting

Command not found?

Restart Termux and try again.

---

Installation stopped?

Run:

bash install.sh

---

Slow replies?

Close background apps and keep phone cool.

---

🔒 Privacy

Runs 100% offline after install.
No data is sent anywhere.

---

⭐ If this project helped you, please star the repo on GitHub.
