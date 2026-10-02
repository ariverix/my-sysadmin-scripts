#!/usr/bin/env bash
# Мониторинг ресурсов: раз в INTERVAL секунд дописывает в лог
# снимок free -h, df -h и uptime с временной меткой.
# Запуск:  ./script.sh      бесконечно, остановка Ctrl+C
#          ./script.sh 3    3 снимка и выход
# Путь к логу: LOG_FILE=/tmp/m.log ./script.sh

set -u

INTERVAL=5
LOG_FILE="${LOG_FILE:-monitor.log}"
COUNT="${1:-0}"
taken=0

die() { echo "Ошибка: $*" >&2; exit 1; }

[[ "$COUNT" =~ ^[0-9]+$ ]] || die "число снимков должно быть целым числом >= 0, получено: '$COUNT'"

for cmd in free df uptime date; do
    command -v "$cmd" >/dev/null 2>&1 || die "не найдена команда '$cmd'"
done

touch "$LOG_FILE" 2>/dev/null || die "нет прав на запись в '$LOG_FILE'"

trap 'echo; echo "Остановлено. Снимков записано: $taken, лог: $LOG_FILE"; exit 0' INT TERM

snapshot() {
    {
        echo "--- $(date '+%Y-%m-%d %H:%M:%S') ---"
        free -h
        echo
        df -h
        echo
        uptime
        echo
    } >> "$LOG_FILE"
}

echo "Мониторинг запущен: интервал ${INTERVAL} с, лог $LOG_FILE (Ctrl+C для остановки)"
while :; do
    snapshot
    taken=$((taken + 1))
    echo "[$taken] снимок записан в $(date '+%H:%M:%S')"
    (( COUNT > 0 && taken >= COUNT )) && break
    sleep "$INTERVAL"
done
echo "Готово. Снимков записано: $taken, лог: $LOG_FILE"
