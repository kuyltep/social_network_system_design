System Design course

# VK.com System

## Функциональные требования

1. Добавление друзей
2. Удаление друзей
3. Просмотр профиля пользователя
4. Просмотр списка друзей пользователя
5. Авторизация, регистрация, выход пользователя
6. Список постов для ленты пользователя
7. Создание постов
8. Добавление медиа (картинки, видео) к постам
9. Просмотр сообщений в чатах пользователя 
10. Отправка сообщений в чаты
11. Просмотр статусов (онлайн/оффлайн)


## Нефункциональные требования

1. Посты хранятся вечно
2. Сообщения хранятся вечно
3. Медиа хранятся вечно
4. Максимальная длина поста 3000 символов
5. Максимальная длина сообщения 3000 символов
6. Максимальное количество медиа в одном посте 5 штук
7. Максимальный размер 1 медиа 3 mb
8. Сезонности у системы нет
9. Availability 99,95%
10. Геораспределенность на центральную, южную, восточную часть России
11. MAU - 87 000 000
12. DAU - 57 000 000
13. В среднем пользователь создает пост раз в 4 дня
14. В среднем пользователь просматривает ленту 8 раз в день
15. Response time на просмотр - 10 секунд, на запись - 40 секунд

## Рассчеты для системы

#### RPS write = 57 000 000 / 86 400 / 4 = 165
#### RPS read = 57 000 000 / 86 400 * 8 = 5278

#### Трафик для создания поста = 3000 * 2 / 1024 = 6 kb (без медиа)
#### Дневной трафик для создания постов = 6 * 165 * 86 400 = 13,6 gb (без медиа)
#### Расчитаем средний трафик для медиа с учетом того, что в серднем на пост приходится 0,5 медиа и возьмем максимальный их размер = 0,5 * 3 * 165 * 86 400 = 20,4 tb
#### Итоговый дневной трафик = 20,4 tb + 13,6 gb = 20,6 tb

#### Размер базы данных для хранения постов на 5 лет = 13,6 gb * 365 * 5 = 25 tb
#### Размер S3 для хранения медиа на 5 лет = 20,6 tb * 365 * 5 = 37 595 tb

#### Количество дисков = 25 tb / 5 = 6 дисков по 5 tb (с запасам) 3 шарда по 2 tb каждый





