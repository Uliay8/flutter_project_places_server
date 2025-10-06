import 'package:places_backend/database/database_helper.dart';
import 'package:places_backend/models/place.dart';

/// Сервис для работы с местами
/// Содержит бизнес-логику для операций с данными о местах
class PlaceService {
  /// Получение всех мест из базы данных
  /// Возвращает список всех доступных мест
  static List<Place> getAllPlaces() {
    try {
      return DatabaseHelper.getAllPlaces();
    } catch (e) {
      print('Ошибка при получении списка мест: $e');
      return [];
    }
  }
}
