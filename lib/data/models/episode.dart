import 'dart:convert';

class Episode {
  int id;
  String name;
  String airDate;
  String episode;
  List<String> characters;
  String url;
  String created;

  Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({
      'id': id,
      'name': name,
      'airDate': airDate,
      'episode': episode,
      'characters': characters,
      'url': url,
      'created': created,
    });

    return result;
  }

  factory Episode.fromMap(Map<String, dynamic> map) {
    return Episode(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      airDate: map['air_date'] ?? '',
      episode: map['episode'] ?? '',
      characters: List<String>.from(map['characters']),
      url: map['url'] ?? '',
      created: map['created'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Episode.fromJson(String source) =>
      Episode.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Episode(id: $id, name: $name, airDate: $airDate)';
  }
}
