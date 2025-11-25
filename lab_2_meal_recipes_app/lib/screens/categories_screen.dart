import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/meal.dart';
import '../services/meal_api_service.dart';
import '../widgets/category_card.dart';
import 'meals_by_category_screen.dart';
import 'meal_detail_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Future<List<MealCategory>> _futureCategories;
  final TextEditingController _searchController = TextEditingController();
  List<MealCategory> _allCategories = [];
  List<MealCategory> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    _futureCategories = MealApiService.fetchCategories();
    _load();
    _searchController.addListener(_onSearchChanged);
  }

  void _load() async {
    final categories = await _futureCategories;
    setState(() {
      _allCategories = categories;
      _filteredCategories = categories;
    });
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCategories = _allCategories.where(
            (c) => c.name.toLowerCase().contains(query),
      ).toList();
    });
  }

  Future<void> _openRandom() async {
    final meal = await MealApiService.fetchRandomMeal();
    if (!mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MealDetailScreen(mealDetailFromRandom: meal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meal Categories")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Search categories...",
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: FutureBuilder(
                future: _futureCategories,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: _filteredCategories.length,
                    itemBuilder: (ctx, i) {
                      final cat = _filteredCategories[i];
                      return CategoryCard(
                        category: cat,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  MealsByCategoryScreen(categoryName: cat.name),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // ⭐ Bottom Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: _openRandom,
          icon: const Icon(Icons.shuffle, color: Colors.white),
          label: const Text(
            "Random Recipe of the Day",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
