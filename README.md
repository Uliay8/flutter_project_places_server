# Backend для flutter_project_places - Бэкенд с базой данных мест

## Требования

Для работы с базой данных необходимо установить SQLite3.

## Начало работы:

### 1. Инициализация базы данных

```bash
# Перейти в корневую папку проекта
cd path/to/

# Выполнить инициализацию
sqlite3 database/places.db ".read database/init.sql"

# Проверить результат
sqlite3 database/places.db "SELECT id FROM places;"
```

P.S.: если вы измените название базы данных, то имейте в виду, что вам также необходимо будет изменить название в файле `database_helper.dart`.

### 2. Установка зависимостей

```bash
# Установить зависимости
dart pub get
```

### 3. Запуск сервера

```bash
# Запустить сервер
dart run bin/main.dart
```

### 4. Для корректной работы можете проверить следующие настройки (для Android эмулятора):

#### При запуске на android:

Добавьте в AndroidManifest.xml следующие разрешения:

```xml
 <uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

Также настройте конфигурацию сетевой безопасности `network_security_config.xml` для разрешения HTTP соединений с localhost:

```xml
<network-security-config>
    <domain-config cleartextTrafficPermitted="true">
        <domain includeSubdomains="true">localhost</domain>
        <domain includeSubdomains="true">127.0.0.1</domain>
        <domain includeSubdomains="true">10.0.2.2</domain>
    </domain-config>
</network-security-config>
```

И добавьте ссылку на эту конфигурацию в манифест:

```xml
<application
    android:networkSecurityConfig="@xml/network_security_config"
    ...
>
```

Ещё требуется для Android эмулятора указать 10.0.2.2 для доступа к localhost хост-машины.

На этом настройка завершена.

## Структура проекта

```
server_places/
├── database/
│   ├── init.sql          # SQL скрипт для инициализации
│   └── places.db         # База данных SQLite (создается автоматически)
├── bin/
│   └── main.dart         # Точка входа, инициализация сервера и БД
└── lib/
    ├── database/
    │   └── database_helper.dart  # Помощник для работы с БД
    ├── models/
    │   └── place.dart    # Модель места
    ├── server/
    │   └── routes.dart    # Маршрутизация HTTP запросов
    └── services/
        └── place_service.dart    # Бизнес-логика для работы с местами

```
