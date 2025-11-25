import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/meal_api_service.dart';

class MealDetailScreen extends StatefulWidget {
  final String? mealId;
  final MealDetail? mealDetailFromRandom;

  const MealDetailScreen({super.key, this.mealId, this.mealDetailFromRandom});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  late Future<MealDetail> _future;

  @override
  void initState() {
    super.initState();
    if (widget.mealDetailFromRandom != null) {
      _future = Future.value(widget.mealDetailFromRandom);
    } else {
      _future = MealApiService.fetchMealDetail(widget.mealId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recipe Details")),
      body: FutureBuilder(
        future: _future,
        builder: (ctx, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final meal = snap.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(meal.thumbnail, height: 260, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.name,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          Chip(label: Text("Category: ${meal.category}")),
                          Chip(label: Text("Area: ${meal.area}")),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Ingredients",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ...meal.ingredients.map((i) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(i.name),
                            Text(i.measure),
                          ],
                        ),
                      )),
                      const SizedBox(height: 20),
                      const Text(
                        "Instructions",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(meal.instructions),
                      const SizedBox(height: 20),
                      if (meal.youtubeUrl != null &&
                          meal.youtubeUrl!.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "YouTube",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            SelectableText(
                              meal.youtubeUrl!,
                              style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
