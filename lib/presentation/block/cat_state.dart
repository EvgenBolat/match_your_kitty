import 'package:match_your_kitty/domain/cat.dart';

abstract class CatState {}

class CatInitial extends CatState {}

class CatLoading extends CatState {}

class CatLoaded extends CatState {
  final List<Cat> catList;
  final int likeCount;
  final String? errorMessage;

  CatLoaded(this.catList, this.likeCount, {this.errorMessage});
}
