import 'package:match_your_kitty/domain/models/breed.dart';

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
    final breeds =
        (json['breeds'] as List<dynamic>?)
            ?.map((e) => Breed.fromJson(e))
            .toList() ??
        [];
    return Cat(
      id: json['id'],
      url: json['url'],
      breeds: breeds,
      breedName: breeds.isEmpty ? breeds[0].name : 'Unknown Breed',
    );
  }
}
