import 'package:flutter/material.dart';
import 'package:poke_app/core/constants/app_colors.dart';

class FavoritesBadge extends StatelessWidget {
  final int count;
  final Function() onFavoritePressed;
  const FavoritesBadge({
    super.key,
    required this.count,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () {
            onFavoritePressed();
          },
        ),
        Positioned(
          right: 4,
          top: 4,
          child: Container(
            padding: const EdgeInsets.all(2),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.favorite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                count.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
