import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:match_your_kitty/application/liked_cat/liked_cat_event.dart';
import 'package:match_your_kitty/application/liked_cat/liked_cat_state.dart';
import 'package:match_your_kitty/domain/repositories/liked_cat_repository.dart';

class LikedCatBloc extends Bloc<LikedCatEvent, LikedCatsState> {
  final ILikedCatsRepository repository;

  LikedCatBloc(this.repository)
    : super(LikedCatsState(likedCats: [], isLoading: false)) {
    on<LoadLikedCats>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      try {
        final cats = await repository.fetchLikedCats();
        emit(state.copyWith(likedCats: cats, isLoading: false));
      } catch (e) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Ошибка загрузки лайкнутых котов',
          ),
        );
      }
    });

    on<AddLikedCat>((event, emit) async {
      try {
        await repository.addLikedCat(event.cat);
        final updated = [...state.likedCats, event.cat];
        emit(state.copyWith(likedCats: updated));
      } catch (e) {
        emit(state.copyWith(errorMessage: 'Не удалось сохранить кота'));
      }
    });

    on<RemoveLikedCat>((event, emit) async {
      try {
        await repository.removeLikedCat(event.id);
        final updated = state.likedCats.where((c) => c.id != event.id).toList();
        emit(state.copyWith(likedCats: updated));
      } catch (e) {
        emit(state.copyWith(errorMessage: 'Не удалось удалить кота'));
      }
    });

    on<SetBreedFilter>((event, emit) {
      emit(state.copyWith(selectedBreedFilter: event.breed));
    });
  }
}
