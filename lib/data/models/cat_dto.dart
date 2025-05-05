class CatDto {
  final String id;
  final String url;
  final List<dynamic> breeds;

  CatDto({required this.id, required this.url, required this.breeds});

  factory CatDto.fromJson(Map<String, dynamic> json) {
    return CatDto(
      id: json['id'],
      url: json['url'],
      breeds: json['breeds'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'url': url, 'breeds': breeds};
  }
}
