import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/meal_api_service.dart';
import '../widgets/meal_grid_item.dart';
import 'meal_detail_screen.dart';
import '../services/favorites_service.dart';



class MealsByCategoryScreen extends StatefulWidget {
  final String categoryName;

  const MealsByCategoryScreen({super.key, required this.categoryName});

  @override
  State<MealsByCategoryScreen> createState() => _MealsByCategoryScreenState();
}

class _MealsByCategoryScreenState extends State<MealsByCategoryScreen> {
  late Future<List<MealSummary>> _futureMeals;
  final TextEditingController _searchController = TextEditingController();
  List<MealSummary> _allMeals = [];
  List<MealSummary> _filteredMeals = [];
  Set<String> _favoriteIds = {};


  @override
  void initState() {
    super.initState();
    _futureMeals = MealApiService.fetchMealsByCategory(widget.categoryName);
    load();
    loadFavorites();
    _searchController.addListener(search);
  }
  void loadFavorites() async {
    final favs = await FavoritesService.getFavorites();
    setState(() {
      _favoriteIds = favs;
    });
  }


  void load() async {
    final meals = await _futureMeals;
    setState(() {
      _allMeals = meals;
      _filteredMeals = meals;
    });
  }

  void search() {
    final q = _searchController.text.toLowerCase();
    setState(() {
      _filteredMeals =
          _allMeals.where((m) => m.name.toLowerCase().contains(q)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName)),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: "Search meals...",
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: FutureBuilder(
              future: _futureMeals,
              builder: (ctx, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(4),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: _filteredMeals.length,
                  itemBuilder: (_, i) {
                    final meal = _filteredMeals[i];
                    return MealGridItem(
                      meal: meal,
                      isFavorite: _favoriteIds.contains(meal.id),
                      onToggleFavorite: () async {
                        await FavoritesService.toggleFavorite(meal.id);
                        loadFavorites();
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MealDetailScreen(mealId: meal.id),
                          ),
                        );
                      },
                    );

                  },
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
