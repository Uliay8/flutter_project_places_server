abstract class ServerStrings {
  // Конфигурация сервера
  static const String defaultHost = 'localhost';
  static const int defaultPort = 8080;
  
  // Переменные окружения
  static const String hostEnvKey = 'HOST';
  static const String portEnvKey = 'PORT';
  
  // Эндпоинты API
  static const endpoints = {
    'GET /': 'Информация об API',
    'GET /places': 'Получить все места',
    'GET /places/{id}': 'Получить место по ID - не работает',
    'GET /places/search?q={query}': 'Поиск мест по названию - не работает',
    'GET /places/type/{type}': 'Получить места по типу - не работает',
    'GET /health': 'Проверка состояния сервера'
  };
  
  // Вспомогательные методы для получения конфигурации
  static String getHost(Map<String, String> environment) {
    return environment[hostEnvKey] ?? defaultHost;
  }
  
  static int getPort(Map<String, String> environment) {
    return int.parse(environment[portEnvKey] ?? defaultPort.toString());
  }
  
  static String getBaseUrl(Map<String, String> environment) {
    final host = getHost(environment);
    final port = getPort(environment);
    return 'http://$host:$port';
  }
}
