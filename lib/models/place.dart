class Place {
  final int id;
  final String name;
  final String description;
  final String type;
  final List<String> urls;
  final double lat;
  final double lng;

  Place({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.urls,
    required this.lat,
    required this.lng,
  });

  // Создание объекта Place из Map (для работы с базой данных)
  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      type: map['type'] as String,
      urls: (map['urls'] as String).split(','),
      lat: map['lat'] as double,
      lng: map['lng'] as double,
    );
  }

  // Преобразование объекта Place в Map (для сохранения в базу данных)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'urls': urls.join(','),
      'lat': lat,
      'lng': lng,
    };
  }

  // Преобразование в JSON для API ответа
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'urls': urls,
      'lat': lat,
      'lng': lng,
    };
  }

  @override
  String toString() {
    return 'Place{id: $id, name: $name, description: $description, type: $type, urls: $urls, lat: $lat, lng: $lng}';
  }
}