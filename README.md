# rffmpeg
Включение записи в реальном времени через ffmpeg используя протокол RTMP

# Конфигурация
* <b>START_TIMEOUT</b> - При запуске стрима идет пауза (3 - сек)
* <b>STOP_TIMEOUT</b> - Завершение записи по определенному времени (00:00:00 - Безограничение)
* <b>CURSOR</b> - Нюхать курсор (0 не используется)
* <b>WINDOW_ID</b> - Нюхать определенное окно (xwininfo - понюхать id)

# Установка
1. Пожалуйста используйте команду <code>git clone</code> чтобы склонировать
2. Измените пожалуйста файл <b>SERVER</b> наш сервер подключение
3. Измените пожалуйста файл <b>STREAM_KEY</b> наш ключ подключение к серверу (Если он есть)
4. Пожалуйста запустите стрим используя команду <code>./rffmpeg.sh</code>
5. Готова :)

# Поддержка
* <a href="https://paypal.me/xirin1337">Поддержать наш проект через paypal</a>
