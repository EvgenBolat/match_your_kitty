class Cat {
  final String id;
  final String url;
  final List<Breed> breeds;
  final String? breedName;

  Cat({
    required this.id,
    required this.url,
    required this.breeds,
    this.breedName,
  });

  factory Cat.fromJson(Map<String, dynamic> json) {
    List<Breed> breedList = [];
    if (json['breeds'] != null) {
      breedList =
          (json['breeds'] as List)
              .map((breedData) => Breed.fromJson(breedData))
              .toList();
    }

    return Cat(
      id: json['id'],
      url: json['url'],
      breeds: breedList,
      breedName: breedList.isNotEmpty ? breedList[0].name : 'Unknown Breed',
    );
  }
}

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
