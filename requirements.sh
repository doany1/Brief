#!/usr/bin/env bash
set -euo pipefail

# Add auto-attach hook to ~/.bashrc if not already present.
HOOK_LINE='[ -f ~/.brief/autoattach.sh ] && source ~/.brief/autoattach.sh'
PROFILE="${HOME}/.bashrc"

if ! grep -Fq "$HOOK_LINE" "$PROFILE"; then
  printf "\n# Brief auto-attach\n%s\n" "$HOOK_LINE" >> "$PROFILE"
  echo "[+] Added auto-attach hook to ${PROFILE}"
else
  echo "[*] Auto-attach hook already present in ${PROFILE}"
fi

if [ -f "brief.py" ]; then
  sudo cp brief.py /usr/local/bin/brief
  sudo chmod +x /usr/local/bin/brief
  echo "[+] Installed brief to /usr/local/bin/brief"
else
  echo "[!] brief.py not found in current directory"
fi
