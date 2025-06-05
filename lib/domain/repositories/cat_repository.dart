import 'package:match_your_kitty/domain/models/cat.dart';
import 'package:match_your_kitty/data/services/cat_api_client.dart';

class CatRepository {
  final CatApiClient apiClient;

  CatRepository(this.apiClient);

  Future<Cat> getCat() async {
    final dto = await apiClient.fetchRandomCat();
    return Cat.fromJson(dto.toJson());
  }
}
