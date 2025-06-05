import 'package:match_your_kitty/domain/models/cat.dart';

abstract class CatState {}

class CatInitial extends CatState {}

class CatLoading extends CatState {}

class CatLoaded extends CatState {
  final List<Cat> catList;
  final String? errorMessage;

  CatLoaded(this.catList, {this.errorMessage});
}
