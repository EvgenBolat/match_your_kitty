import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CatCard extends StatefulWidget {
  final String imageUrl;
  final String? breedName;
  final VoidCallback onNext;
  final VoidCallback onLike;
  final bool isInteractive;

  const CatCard({
    super.key,
    required this.imageUrl,
    this.breedName,
    required this.onNext,
    required this.onLike,
    required this.isInteractive,
  });

  @override
  State<CatCard> createState() => _CatCardState();
}

class _CatCardState extends State<CatCard> {
  final animationDuration = const Duration(milliseconds: 200);

  Offset _position = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final double cardHeight = 350;
    final double cardWidth = screenWidth * 0.8;

    return GestureDetector(
      onPanUpdate:
          widget.isInteractive
              ? (details) {
                setState(() {
                  _position += details.delta;
                });
              }
              : (details) {
                setState(() {
                  _position = Offset.zero;
                });
              },
      onPanEnd:
          widget.isInteractive
              ? (details) async {
                final isLiked = _position.dx > screenWidth / 3;
                final isDisliked = _position.dx < -screenWidth / 3;

                if (isLiked || isDisliked) {
                  final endOffset = Offset(
                    isLiked ? screenWidth * 1.5 : -screenWidth * 1.5,
                    0,
                  );

                  setState(() {
                    _position = endOffset;
                  });

                  await Future.delayed(animationDuration);

                  if (isLiked) {
                    widget.onLike();
                  } else {
                    widget.onNext();
                  }
                }

                setState(() {
                  _position = Offset.zero;
                });
              }
              : null,
      child: AnimatedContainer(
        duration: animationDuration,
        transform:
            Matrix4.identity()
              ..rotateZ(_position.dx / screenWidth * 0.3)
              ..translate(_position.dx, (_position.dx.abs() * -0.5)),
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 5,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: widget.imageUrl,
              width: cardWidth,
              height: cardHeight * 0.7,
              fit: BoxFit.cover,
              placeholder:
                  (context, url) =>
                      const CircularProgressIndicator(strokeWidth: 2),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                widget.breedName ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
