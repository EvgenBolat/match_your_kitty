import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:match_your_kitty/application/cat/cat_bloc.dart';
import 'package:match_your_kitty/application/cat/cat_event.dart';
import 'package:match_your_kitty/application/cat/cat_state.dart';
import 'package:match_your_kitty/domain/models/breed.dart';
import 'package:match_your_kitty/domain/models/cat.dart';
import 'package:match_your_kitty/domain/repositories/cat_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockCatRepository extends Mock implements CatRepository {}

void main() {
  late CatRepository repository;

  setUp(() {
    repository = MockCatRepository();
  });

  final testCat = Cat(
    id: 'test-id',
    url: 'https://example.com/cat.jpg',
    breeds: [
      Breed(
        id: 'abys',
        name: 'Abyssinian',
        temperament: 'Active, Energetic',
        origin: 'Egypt',
        lifeSpan: '14 - 15',
        wikipediaUrl: 'https://en.wikipedia.org/wiki/Abyssinian_(cat)',
      ),
    ],
    breedName: 'Abyssinian',
  );

  blocTest<CatBloc, CatState>(
    'emits [CatLoading, CatLoaded] with 5 cats when LoadInitialCats is added',
    build: () {
      when(() => repository.getCat()).thenAnswer((_) async => testCat);
      return CatBloc(repository);
    },
    act: (bloc) => bloc.add(LoadInitialCats()),
    expect:
        () => [
          isA<CatLoading>(),
          isA<CatLoaded>().having((state) => state.catList.length, 'length', 5),
        ],
  );

  blocTest<CatBloc, CatState>(
    'emits [CatLoading, CatLoaded with error] if getCat throws SocketException',
    build: () {
      when(() => repository.getCat()).thenThrow(SocketException('No internet'));
      return CatBloc(repository);
    },
    act: (bloc) => bloc.add(LoadInitialCats()),
    expect:
        () => [
          isA<CatLoading>(),
          isA<CatLoaded>()
              .having((s) => s.catList, 'catList', isEmpty)
              .having(
                (s) => s.errorMessage,
                'errorMessage',
                contains('Проверьте'),
              ),
        ],
  );

  blocTest<CatBloc, CatState>(
    'emits updated CatLoaded state with one cat removed and new one added on LikeCat',
    build: () {
      when(() => repository.getCat()).thenAnswer((_) async => testCat);
      return CatBloc(repository);
    },
    seed: () => CatLoaded(List.generate(3, (_) => testCat)),
    act: (bloc) => bloc.add(LikeCat()),
    expect:
        () => [
          // после LikeCat: удалён 1 (осталось 2)
          isA<CatLoaded>().having(
            (s) => s.catList.length,
            'catList after remove',
            2,
          ),
          // после LoadCat: добавлен 1 (стало 3)
          isA<CatLoaded>().having(
            (s) => s.catList.length,
            'catList after new load',
            3,
          ),
        ],
    verify: (_) {
      verify(() => repository.getCat()).called(1);
    },
  );
}
