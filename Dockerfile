FROM ubuntu:22.04
# procps: free/uptime для скрипта; python3: HTTP-сервер для отдачи monitor.log
RUN apt-get update && apt-get install -y --no-install-recommends procps python3 \
    && rm -rf /var/lib/apt/lists/*
ENV PYTHONUNBUFFERED=1
WORKDIR /var/www
COPY script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh
EXPOSE 8080
# скрипт пишет monitor.log в фоне, python отдаёт его по HTTP на 8080
CMD ["/bin/bash", "-c", "/usr/local/bin/script.sh & exec python3 -m http.server 8080"]
