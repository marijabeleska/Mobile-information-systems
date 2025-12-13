import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealGridItem extends StatelessWidget {
  final MealSummary meal;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const MealGridItem({
    super.key,
    required this.meal,
    required this.onTap,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Image.network(
                    meal.thumbnail,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: IconButton(
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                      ),
                      onPressed: onToggleFavorite,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                meal.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
