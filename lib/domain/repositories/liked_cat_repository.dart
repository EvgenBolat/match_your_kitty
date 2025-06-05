import 'package:match_your_kitty/data/models/liked_cat.dart';

abstract class ILikedCatsRepository {
  Future<List<LikedCat>> fetchLikedCats();
  Future<void> addLikedCat(LikedCat cat);
  Future<void> removeLikedCat(String id);
  Future<bool> isCatLiked(String id);
}
