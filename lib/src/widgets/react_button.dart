import 'package:flutter/material.dart';

class ReactButtons extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onLike;

  const ReactButtons({super.key, required this.onNext, required this.onLike});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.thumb_down, color: Colors.red, size: 40),
          onPressed: onNext,
        ),
        SizedBox(width: 20),
        IconButton(
          icon: Icon(Icons.thumb_up, color: Colors.green, size: 40),
          onPressed: () {
            onLike();
          },
        ),
      ],
    );
  }
}
