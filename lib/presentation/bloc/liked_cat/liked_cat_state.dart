import 'package:match_your_kitty/data/models/liked_cat.dart';

class LikedCatsState {
  final List<LikedCat> likedCats;
  final String? selectedBreedFilter;
  final bool isLoading;
  final String? errorMessage;

  LikedCatsState({
    required this.likedCats,
    this.selectedBreedFilter,
    this.isLoading = false,
    this.errorMessage,
  });

  List<LikedCat> get filteredCats {
    if (selectedBreedFilter == null || selectedBreedFilter!.isEmpty) {
      return likedCats;
    }
    if (selectedBreedFilter == 'all') {
      return likedCats;
    }
    return likedCats
        .where((cat) => cat.breedName == selectedBreedFilter)
        .toList();
  }

  LikedCatsState copyWith({
    List<LikedCat>? likedCats,
    String? selectedBreedFilter,
    bool? isLoading,
    String? errorMessage,
  }) => LikedCatsState(
    likedCats: likedCats ?? this.likedCats,
    selectedBreedFilter: selectedBreedFilter ?? this.selectedBreedFilter,
    isLoading: isLoading ?? this.isLoading,
    errorMessage: errorMessage,
  );
}
