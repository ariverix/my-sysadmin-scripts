# my-sysadmin-scripts

script.sh раз в 5 секунд дописывает в monitor.log снимок free -h, df -h и uptime с временной меткой.

Запуск: ./script.sh (бесконечно, Ctrl+C для остановки) или ./script.sh 3 (3 снимка и выход). Пример вывода: sample_output.txt

ДЗ2: Dockerfile (контейнер отдаёт monitor.log на 8080), docker-compose.yml (лог на LVM-том /mnt/logs), deploy/ - конфиги nginx (reverse proxy + TLS) и systemd-службы my-app.
