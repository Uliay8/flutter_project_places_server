import 'dart:convert';
import 'package:places_backend/assets/strings/server_strings.dart';
import 'package:places_backend/services/place_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Класс для настройки маршрутов HTTP сервера
class Routes {
  /// Создание и настройка роутера с маршрутами
  static Router createRouter() {
    final router = Router();

    // GET / - корневой маршрут с информацией об API
    router.get('/', _rootHandler);

    // GET /health - проверка состояния сервера
    router.get('/health', _healthHandler);

    // GET /places - получение всех мест
    router.get('/places', _getPlacesHandler);

    return router;
  }

  /// Обработчик для GET /places
  static Response _getPlacesHandler(Request request) {
    try {
      final places = PlaceService.getAllPlaces();
      final placesJson = places.map((place) => place.toJson()).toList();

      return Response.ok(
        jsonEncode(placesJson),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
          'Access-Control-Allow-Headers': 'Content-Type, Authorization',
        },
      );
    } catch (e) {
      return Response.internalServerError(
        body: jsonEncode({
          'error': 'Ошибка при получении списка мест',
          'details': e.toString()
        }),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );
    }
  }

  /// Обработчик для GET /
  static Response _rootHandler(Request request) {
    final apiInfo = {
      'name': 'Places Backend API',
      'version': '1.0.0',
      'description': 'REST API для получения информации о местах',
      'endpoints': ServerStrings.endpoints,
      'example_place': {
        'id': 1,
        'name': 'Место 1',
        'description': 'Описание 1',
        'type': 'Парк',
        'urls': ['https://example.com/image1.jpg'],
        'lat': 55.75,
        'lng': 37.62
      }
    };

    return Response.ok(
      jsonEncode(apiInfo),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Access-Control-Allow-Origin': '*',
      },
    );
  }

  /// Обработчик для GET /health
  static Response _healthHandler(Request request) {
    return Response.ok(
      jsonEncode({
        'status': 'OK',
        'timestamp': DateTime.now().toIso8601String(),
        'uptime': 'Server is running'
      }),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Access-Control-Allow-Origin': '*',
      },
    );
  }
}
