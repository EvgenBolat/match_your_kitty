import 'package:match_your_kitty/data/models/liked_cat.dart';

abstract class LikedCatEvent {}

class LoadLikedCats extends LikedCatEvent {}

class AddLikedCat extends LikedCatEvent {
  final LikedCat cat;
  AddLikedCat(this.cat);
}

class RemoveLikedCat extends LikedCatEvent {
  final String id;
  RemoveLikedCat(this.id);
}

class SetBreedFilter extends LikedCatEvent {
  final String? breed;
  SetBreedFilter(this.breed);
}
