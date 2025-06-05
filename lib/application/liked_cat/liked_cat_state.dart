import 'package:equatable/equatable.dart';
import 'package:match_your_kitty/data/models/liked_cat.dart';

class LikedCatsState extends Equatable {
  final List<LikedCat> likedCats;
  final bool isLoading;
  final String? errorMessage;
  final String? selectedBreedFilter;

  const LikedCatsState({
    required this.likedCats,
    this.isLoading = false,
    this.errorMessage,
    this.selectedBreedFilter,
  });

  LikedCatsState copyWith({
    List<LikedCat>? likedCats,
    bool? isLoading,
    String? errorMessage,
    String? selectedBreedFilter,
  }) {
    return LikedCatsState(
      likedCats: likedCats ?? this.likedCats,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      selectedBreedFilter: selectedBreedFilter ?? this.selectedBreedFilter,
    );
  }

  List<LikedCat> get filteredCats {
    if (selectedBreedFilter == null || selectedBreedFilter == 'all') {
      return likedCats;
    }
    return likedCats
        .where((cat) => cat.breedName == selectedBreedFilter)
        .toList();
  }

  @override
  List<Object?> get props => [
    likedCats,
    isLoading,
    errorMessage,
    selectedBreedFilter,
  ];
}
