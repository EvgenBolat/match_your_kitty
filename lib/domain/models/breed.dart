class Breed {
  final String id;
  final String name;
  final String temperament;
  final String origin;
  final String lifeSpan;
  final String? wikipediaUrl;

  Breed({
    required this.id,
    required this.name,
    required this.temperament,
    required this.origin,
    required this.lifeSpan,
    this.wikipediaUrl,
  });

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(
      id: json['id'],
      name: json['name'],
      temperament: json['temperament'] ?? 'Unknown',
      origin: json['origin'] ?? 'Unknown',
      lifeSpan: json['life_span'] ?? 'Unknown',
      wikipediaUrl: json['wikipedia_url'],
    );
  }
}
