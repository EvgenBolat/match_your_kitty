import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:match_your_kitty/domain/cat.dart';
import 'package:match_your_kitty/domain/cat_repository.dart';
import 'package:match_your_kitty/application/cat/cat_event.dart';
import 'package:match_your_kitty/application/cat/cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  final CatRepository repository;

  CatBloc(this.repository) : super(CatInitial()) {
    on<LoadInitialCats>((event, emit) async {
      emit(CatLoading());
      final cats = <Cat>[];
      String? error;
      for (int i = 0; i < 5; i++) {
        try {
          final cat = await repository.getCat();
          cats.insert(0, cat);
        } on SocketException {
          error = 'Проверьте соединение с интернетом';
          break;
        } catch (e) {
          if (e is DioException) {
            switch (e.type) {
              case DioExceptionType.connectionTimeout:
              case DioExceptionType.receiveTimeout:
              case DioExceptionType.sendTimeout:
                error = 'Время ожидания истекло. Попробуйте снова.';
                break;
              case DioExceptionType.connectionError:
                error = 'Проверьте подключение к интернету.';
                break;
              case DioExceptionType.badCertificate:
                error = 'Проблема с SSL-сертификатом.';
                break;
              case DioExceptionType.badResponse:
                error = 'Ошибка сервера';
                break;
              case DioExceptionType.cancel:
                error = 'Запрос был отменен.';
                break;
              case DioExceptionType.unknown:
                error = 'Произошла неизвестная ошибка: ${e.message}';
                break;
            }
          }
          error =
              error ??
              'Произошла ошибка. Попробуйте снова либо зайдите позднее';
          break;
        }
      }
      emit(CatLoaded(cats, errorMessage: cats.isEmpty ? error : null));
    });

    on<LoadCat>((event, emit) async {
      if (state is CatLoaded) {
        final currentState = state as CatLoaded;
        try {
          final cat = await repository.getCat();
          final updatedList = List<Cat>.from(currentState.catList);
          updatedList.insert(0, cat);
          emit(CatLoaded(updatedList));
        } catch (_) {
          emit(
            CatLoaded(
              currentState.catList,
              errorMessage: 'Ошибка загрузки котиков',
            ),
          );
        }
      }
    });

    on<LikeCat>((event, emit) async {
      if (state is CatLoaded) {
        final currentState = state as CatLoaded;
        final updatedList = List<Cat>.from(currentState.catList);
        if (updatedList.isNotEmpty) updatedList.removeLast();
        emit(CatLoaded(updatedList, errorMessage: currentState.errorMessage));
        add(LoadCat());
      }
    });

    on<NextCat>((event, emit) async {
      if (state is CatLoaded) {
        final currentState = state as CatLoaded;
        final updatedList = List<Cat>.from(currentState.catList);
        if (updatedList.isNotEmpty) updatedList.removeLast();
        emit(CatLoaded(updatedList, errorMessage: currentState.errorMessage));
        add(LoadCat());
      }
    });
  }
}
