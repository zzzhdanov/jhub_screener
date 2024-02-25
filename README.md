## Инструкция по запуску

1) `docker build -t ijscreener .`
2) `docker run --name j_screener \
           --privileged \
           -d \
           -p 8001:8000 \
           -v auth_data:/home \
           timage`
