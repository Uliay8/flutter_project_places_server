import 'dart:io';
import 'package:places_backend/assets/strings/server_strings.dart';
import 'package:places_backend/database/database_helper.dart';
import 'package:places_backend/server/routes.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

/// Главная функция для запуска HTTP сервера
void main(List<String> arguments) async {
  // Инициализация базы данных
  print('Инициализация базы данных...');
  try {
    // Проверяем подключение к базе данных
    await DatabaseHelper.database;
    print('База данных успешно инициализирована');
  } catch (e) {
    print('Ошибка при инициализации базы данных: $e');
    exit(1);
  }

  // Создание роутера с маршрутами
  final router = Routes.createRouter();

  // Настройка middleware для CORS и логирования
  final handler = Pipeline()
      .addMiddleware(corsHeaders())
      .addMiddleware(logRequests())
      .addHandler(router);

  // Получение конфигурации сервера из ServerStrings
  final host = ServerStrings.getHost(Platform.environment);
  final port = ServerStrings.getPort(Platform.environment);
  final baseUrl = ServerStrings.getBaseUrl(Platform.environment);

  // Запуск HTTP сервера
  try {
    final server = await serve(handler, host, port);
    print('🚀 Сервер запущен на $baseUrl');
    print('📍 API эндпоинты:');
    ServerStrings.endpoints.forEach((endpoint, description) {
      print('   $endpoint $baseUrl${endpoint.replaceFirst('GET ', '')} - $description');
    });
    print('');
    print('Для остановки сервера нажмите Ctrl+C');

    // Обработка сигнала завершения для корректного закрытия
    ProcessSignal.sigint.watch().listen((signal) {
      print('\n🛑 Получен сигнал завершения, останавливаем сервер...');
      DatabaseHelper.close();
      server.close(force: true);
      print('✅ Сервер остановлен');
      exit(0);
    });
  } catch (e) {
    print('❌ Ошибка при запуске сервера: $e');
    DatabaseHelper.close();
    exit(1);
  }
}
