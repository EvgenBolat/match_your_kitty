import 'package:dio/dio.dart';
import 'package:match_your_kitty/data/models/cat_dto.dart';

class CatApiClient {
  final Dio dio;

  CatApiClient(this.dio);

  Future<CatDto> fetchRandomCat() async {
    final response = await dio.get(
      '/images/search',
      queryParameters: {'has_breeds': true, 'limit': 1},
    );
    if (response.data is List && response.data.isNotEmpty) {
      return CatDto.fromJson(response.data[0]);
    }
    throw Exception("No cat data");
  }
}
