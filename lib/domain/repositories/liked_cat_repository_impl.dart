import 'package:match_your_kitty/data/database/app_database.dart';
import 'package:match_your_kitty/data/database/liked_cat_mapper.dart';
import 'package:match_your_kitty/data/models/liked_cat.dart';
import 'package:match_your_kitty/domain/repositories/liked_cat_repository.dart';

class LikedCatsRepositoryImpl implements ILikedCatsRepository {
  final AppDatabase db;

  LikedCatsRepositoryImpl(this.db);

  @override
  Future<List<LikedCat>> fetchLikedCats() async {
    final rows = await db.getAllLikedCats();
    return rows.map((e) => e.toModel()).toList();
  }

  @override
  Future<void> addLikedCat(LikedCat cat) async {
    await db.insertLikedCat(cat.toDb());
  }

  @override
  Future<void> removeLikedCat(String id) async {
    await db.deleteLikedCat(id);
  }

  @override
  Future<bool> isCatLiked(String id) => db.isLiked(id);
}
