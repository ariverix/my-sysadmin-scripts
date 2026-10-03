FROM ubuntu:22.04
# procps даёт free и uptime, в базовом образе ubuntu их нет
RUN apt-get update && apt-get install -y --no-install-recommends procps \
    && rm -rf /var/lib/apt/lists/*
COPY script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh
# 3 снимка и выход: контейнер завершается, как обычный скрипт
CMD ["/usr/local/bin/script.sh", "3"]
