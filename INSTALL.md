# Установка и настройка проекта

## Требования

### Необходимое ПО

Перед началом работы убедитесь, что установлены:

* Flutter SDK
* Git
* VS Code или Android Studio

### Для Windows

* Windows 10 и новее
* Visual Studio 2019+ с компонентом **Desktop development with C++**
* Windows SDK

### Для Android

* Android Studio
* Android SDK
* JDK (Java Development Kit)

---

## Подготовка проекта

### 1. Клонирование репозитория

Склонируйте проект на локальный компьютер.

### 2. Установка Flutter

1. Скачайте Flutter SDK с официального сайта.
2. Добавьте Flutter в системную переменную `PATH`.
3. Выполните проверку установки:

```bash
flutter doctor
```

Если будут обнаружены отсутствующие компоненты, установите их согласно рекомендациям команды.

### 3. Настройка редактора

Для VS Code рекомендуется:

* установить расширения **Flutter** и **Dart**;
* включить поддержку Flutter;
* использовать встроенное форматирование кода (`dart format`).

### 4. Установка зависимостей

В корне проекта выполните:

```bash
flutter pub get
```

---

# Настройка среды сборки

## Windows

### Установка Visual Studio

При установке Visual Studio выберите следующие компоненты:

* Desktop development with C++
* Windows SDK
* Visual C++ tools for CMake

### Включение режима разработчика

Откройте:

**Параметры → Обновление и безопасность → Для разработчиков**

и активируйте пункт **Режим разработчика**.

### Проверка поддержки Windows

```bash
flutter config --enable-windows-desktop
flutter doctor -v
```

---

## Android

### Установка Android Studio

После установки Android Studio:

1. Завершите первоначальную настройку.
2. Откройте SDK Manager.
3. Установите следующие компоненты:

   * Android SDK Build-Tools
   * Android SDK Platform-Tools
   * Android SDK Command-line Tools

### Настройка Android Studio

Дополнительно установите плагины:

* Flutter
* Dart

После этого настройте Android SDK и создайте виртуальное устройство для тестирования.

### Подпись релизных сборок

Для выпуска приложения потребуется keystore.

Создайте его командой:

```bash
keytool -genkey -v -keystore android/app/upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

Создайте файл `android/key.properties`:

```properties
storePassword=<пароль_keystore>
keyPassword=<пароль_ключа>
keyAlias=upload
storeFile=app/upload-keystore.jks
```

Добавьте файл в `.gitignore`, чтобы не хранить конфиденциальные данные в репозитории.

Проверьте корректность настройки:

```bash
flutter doctor -v
```

---

# Сборка приложения

## Android

### Debug-сборка

Используется для тестирования и отладки:

```bash
flutter build apk --debug
```

### Release-сборка

Используется для публикации:

```bash
flutter build apk --release
```

### Раздельные APK по архитектурам

Позволяет уменьшить размер итоговых файлов:

```bash
flutter build apk --split-per-abi
```

---

# Где находятся результаты сборки

### APK для отладки

```text
build/app/outputs/flutter-apk/app-debug.apk
```

### Релизный APK

```text
build/app/outputs/flutter-apk/app-release.apk
```

### APK по архитектурам

```text
build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk
build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
build/app/outputs/flutter-apk/app-x86_64-release.apk
```

---

# Запуск приложения на Windows

Убедитесь, что установлены:

* Visual Studio с поддержкой C++;
* Windows SDK.

Включите поддержку Windows-приложений:

```bash
flutter config --enable-windows-desktop
```

Запустите проект:

```bash
flutter run -d windows
```

---

# Запуск в Android-эмуляторе

## Создание устройства

1. Откройте Android Studio.
2. Перейдите в **Tools → Device Manager**.
3. Нажмите **Create Device**.
4. Выберите модель устройства (например, Pixel 6).
5. Укажите образ системы (API 33 или новее).
6. Завершите создание эмулятора.

## Запуск эмулятора

Через Device Manager нажмите кнопку запуска либо используйте терминал:

```bash
emulator -avd <имя_эмулятора>
```

## Запуск приложения

После запуска эмулятора выполните:

```bash
flutter run
```

Для конкретного устройства:

```bash
flutter run -d <имя_эмулятора>
```

### Полезные команды во время разработки

| Клавиша | Действие                     |
| ------- | ---------------------------- |
| `r`     | Hot Reload                   |
| `R`     | Полный перезапуск приложения |
| `q`     | Выход из режима разработки   |

---

# Настройка конфигурации

Создайте файл `.env` на основе шаблона:

```bash
cp envexample .env
```

Укажите API-ключ:

```env
OPENROUTER_API_KEY=ваш_ключ
```

---

# Проверка работоспособности

Проверьте состояние Flutter:

```bash
flutter doctor
```

Запустите приложение:

```bash
flutter run
```

Если приложение успешно собирается и запускается, настройка завершена.
