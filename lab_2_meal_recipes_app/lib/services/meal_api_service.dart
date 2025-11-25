import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/category.dart';
import '../models/meal.dart';

class MealApiService {
  static const String _baseUrl = 'themealdb.com';


  static Future<List<MealCategory>> fetchCategories() async {
    final uri = Uri.https(_baseUrl, '/api/json/v1/1/categories.php');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> categoriesJson = data['categories'];
      return categoriesJson
          .map((json) => MealCategory.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<List<MealSummary>> fetchMealsByCategory(String category) async {
    final uri = Uri.https(
      _baseUrl,
      '/api/json/v1/1/filter.php',
      {'c': category},
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic>? mealsJson = data['meals'];
      if (mealsJson == null) return [];
      return mealsJson.map((json) => MealSummary.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }

  static Future<List<MealDetail>> searchMeals(String query) async {
    final uri =
    Uri.https(_baseUrl, '/api/json/v1/1/search.php', {'s': query});
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic>? mealsJson = data['meals'];
      if (mealsJson == null) return [];
      return mealsJson.map((json) => MealDetail.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search meals');
    }
  }

  static Future<MealDetail> fetchMealDetail(String id) async {
    final uri =
    Uri.https(_baseUrl, '/api/json/v1/1/lookup.php', {'i': id});
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> mealsJson = data['meals'];
      return MealDetail.fromJson(mealsJson.first);
    } else {
      throw Exception('Failed to load meal detail');
    }
  }

  static Future<MealDetail> fetchRandomMeal() async {
    final uri = Uri.https(_baseUrl, '/api/json/v1/1/random.php');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> mealsJson = data['meals'];
      return MealDetail.fromJson(mealsJson.first);
    } else {
      throw Exception('Failed to load random meal');
    }
  }
}
