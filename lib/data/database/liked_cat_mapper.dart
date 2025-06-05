import 'package:match_your_kitty/data/database/app_database.dart';
import 'package:match_your_kitty/data/models/liked_cat.dart';

extension LikedCatMapper on LikedCatDb {
  LikedCat toModel() => LikedCat(
    id: id,
    imageUrl: imageUrl,
    breedName: breedName,
    likedAt: likedAt,
  );
}

extension LikedCatModelMapper on LikedCat {
  LikedCatDb toDb() => LikedCatDb(
    id: id,
    imageUrl: imageUrl,
    breedName: breedName,
    likedAt: likedAt,
  );
}
