#!/bin/bash
echo "=== SERVICE ==="
systemctl is-active hermes-chat-agent 2>&1
systemctl is-enabled hermes-chat-agent 2>&1
echo "=== PROCESS ==="
pgrep -af "chat_agent.py poll" || echo "NOT RUNNING"
echo "=== LOG (last 12) ==="
tail -n 12 /var/log/hermes-chat-agent.log 2>/dev/null || echo "no log"
echo "=== TELEGRAM TEST ==="
source /etc/default/hermes-chat-agent 2>/dev/null
curl -s --max-time 10 "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/getMe" | head -c 200
echo ""
echo "=== END ==="
