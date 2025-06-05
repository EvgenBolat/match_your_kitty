import 'package:flutter/material.dart';
import 'package:match_your_kitty/domain/models/cat.dart';
import 'package:match_your_kitty/presentation/widgets/cat_card.dart';

class CatCardList extends StatelessWidget {
  final List<Cat> catList;
  final VoidCallback onNext;
  final Function(Cat) onLike;
  final void Function(Cat) onCardTapped;

  const CatCardList({
    super.key,
    required this.catList,
    required this.onNext,
    required this.onLike,
    required this.onCardTapped,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Stack(
        alignment: Alignment.center,
        children:
            catList.asMap().entries.map((entry) {
              final index = entry.key;
              final cat = entry.value;

              return Positioned(
                child: GestureDetector(
                  onTap: () => onCardTapped(cat),
                  child: CatCard(
                    imageUrl: cat.url,
                    breedName:
                        cat.breeds.isNotEmpty ? cat.breeds[0].name : 'Unknown',
                    onNext: onNext,
                    onLike: () => onLike(cat),
                    isInteractive: catList.length - 1 == index,
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
