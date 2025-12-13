import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/favorites_service.dart';
import '../services/meal_api_service.dart';
import 'meal_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late Future<List<MealDetail>> _future;

  @override
  void initState() {
    super.initState();
    _future = _loadFavorites();
  }

  Future<List<MealDetail>> _loadFavorites() async {
    final ids = await FavoritesService.getFavorites();
    final meals = <MealDetail>[];
    for (final id in ids) {
      meals.add(await MealApiService.fetchMealDetail(id));
    }
    return meals;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Recipes")),
      body: FutureBuilder<List<MealDetail>>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final meals = snapshot.data!;
          if (meals.isEmpty) {
            return const Center(child: Text("No favorite recipes yet."));
          }

          return ListView.builder(
            itemCount: meals.length,
            itemBuilder: (context, i) {
              final meal = meals[i];
              return ListTile(
                leading: Image.network(
                  meal.thumbnail,
                  width: 60,
                  fit: BoxFit.cover,
                ),
                title: Text(meal.name),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          MealDetailScreen(mealId: meal.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
