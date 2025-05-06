// liked_cats_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:match_your_kitty/presentation/bloc/liked_cat/liked_cat_event.dart';

import 'liked_cat_state.dart';

class LikedCatBloc extends Bloc<LikedCatEvent, LikedCatsState> {
  LikedCatBloc() : super(LikedCatsState(likedCats: [])) {
    on<AddLikedCat>((event, emit) {
      emit(state.copyWith(likedCats: [...state.likedCats, event.cat]));
    });

    on<RemoveLikedCat>((event, emit) {
      emit(
        state.copyWith(
          likedCats: state.likedCats.where((c) => c.id != event.id).toList(),
        ),
      );
    });

    on<SetBreedFilter>((event, emit) {
      emit(state.copyWith(selectedBreedFilter: event.breed));
    });

    on<SetLoading>((event, emit) {
      emit(state.copyWith(isLoading: event.isLoading));
    });

    on<SetError>((event, emit) {
      emit(state.copyWith(errorMessage: event.errorMessage));
    });
  }
}
