import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:match_your_kitty/application/liked_cat/liked_cat_bloc.dart';
import 'package:match_your_kitty/application/liked_cat/liked_cat_event.dart';
import 'package:match_your_kitty/application/liked_cat/liked_cat_state.dart';
import 'package:match_your_kitty/data/models/liked_cat.dart';
import 'package:match_your_kitty/domain/repositories/liked_cat_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockLikedCatsRepository extends Mock implements ILikedCatsRepository {}

void main() {
  late MockLikedCatsRepository mockRepo;
  late LikedCatBloc bloc;

  final mockLikedCat = LikedCat(
    id: 'abc123',
    imageUrl: 'https://example.com/cat.jpg',
    breedName: 'Siberian',
    likedAt: DateTime(2023, 1, 1),
  );

  setUp(() {
    mockRepo = MockLikedCatsRepository();
    bloc = LikedCatBloc(mockRepo);
  });

  tearDown(() => bloc.close());

  group('LikedCatBloc', () {
    blocTest<LikedCatBloc, LikedCatsState>(
      'emits updated state after LoadLikedCats',
      build: () {
        when(
          () => mockRepo.fetchLikedCats(),
        ).thenAnswer((_) async => [mockLikedCat]);
        return bloc;
      },
      act: (bloc) => bloc.add(LoadLikedCats()),
      expect:
          () => [
            LikedCatsState(likedCats: [], isLoading: true),
            LikedCatsState(likedCats: [mockLikedCat], isLoading: false),
          ],
    );

    blocTest<LikedCatBloc, LikedCatsState>(
      'emits state with added cat on AddLikedCat',
      build: () {
        when(() => mockRepo.addLikedCat(mockLikedCat)).thenAnswer((_) async {});
        return bloc;
      },
      act: (bloc) => bloc.add(AddLikedCat(mockLikedCat)),
      expect:
          () => [
            LikedCatsState(likedCats: [mockLikedCat], isLoading: false),
          ],
      verify: (_) {
        verify(() => mockRepo.addLikedCat(mockLikedCat)).called(1);
      },
    );

    blocTest<LikedCatBloc, LikedCatsState>(
      'emits state with removed cat on RemoveLikedCat',
      build: () {
        when(() => mockRepo.removeLikedCat('abc123')).thenAnswer((_) async {});
        return bloc;
      },
      seed: () => LikedCatsState(likedCats: [mockLikedCat], isLoading: false),
      act: (bloc) => bloc.add(RemoveLikedCat('abc123')),
      expect: () => [LikedCatsState(likedCats: [], isLoading: false)],
      verify: (_) {
        verify(() => mockRepo.removeLikedCat('abc123')).called(1);
      },
    );

    blocTest<LikedCatBloc, LikedCatsState>(
      'emits state with selected breed filter on SetBreedFilter',
      build: () => bloc,
      act: (bloc) => bloc.add(SetBreedFilter('Siberian')),
      expect:
          () => [
            LikedCatsState(
              likedCats: [],
              isLoading: false,
              selectedBreedFilter: 'Siberian',
            ),
          ],
    );
  });
}
