# Используем официальный образ Redmine 6
FROM redmine:6

# Устанавливаем необходимые системные пакеты от имени root
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential && \
    rm -rf /var/lib/apt/lists/*

# Копируем плагины и темы
# Они попадут в уже готовую файловую систему, не задевая системные entrypoint-скрипты
COPY ./plugins /usr/src/redmine/plugins
COPY ./themes /usr/src/redmine/public/themes

# Переключаемся на пользователя redmine для установки зависимостей
USER redmine
RUN bundle install --without development test

# Важно: снова переключаемся на root, чтобы запустить оригинальный entrypoint-скрипт от redmine
USER root
EXPOSE 3000