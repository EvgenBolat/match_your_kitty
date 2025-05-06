import 'package:match_your_kitty/data/models/liked_cat.dart';

abstract class LikedCatEvent {}

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

class SetLoading extends LikedCatEvent {
  final bool isLoading;
  SetLoading(this.isLoading);
}

class SetError extends LikedCatEvent {
  final String? errorMessage;
  SetError(this.errorMessage);
}
