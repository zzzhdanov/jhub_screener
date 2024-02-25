## Инструкция по запуску

1) `docker build -t ijscreener .`
2) `docker run --name j_screener \
           --privileged \
           -d \
           -p 8000:8000 \
           -v auth_data:/home \
           ijscreener`

### Администрирование
Первая регистрация всегда за администратором!
1) http://localhost:8000/hub/signup
2) Логин - **admin**

http://localhost:8000/hub/authorize - управление пользователями. Доступно только для аккаунта администратора
