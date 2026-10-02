#!/bin/bash
# Мониторинг ресурсов: снимок free/df/uptime раз в N секунд в monitor.log
INTERVAL=5
LOG_FILE=monitor.log

while true; do
    echo "--- $(date '+%Y-%m-%d %H:%M:%S') ---" >> "$LOG_FILE"
    free -h >> "$LOG_FILE"
    df -h >> "$LOG_FILE"
    uptime >> "$LOG_FILE"
    sleep "$INTERVAL"
done
