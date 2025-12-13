import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _key = 'favorite_meals';

  static Future<Set<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_key) ?? []).toSet();
  }

  static Future<bool> isFavorite(String mealId) async {
    final favorites = await getFavorites();
    return favorites.contains(mealId);
  }

  static Future<void> toggleFavorite(String mealId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = (prefs.getStringList(_key) ?? []).toSet();

    if (favorites.contains(mealId)) {
      favorites.remove(mealId);
    } else {
      favorites.add(mealId);
    }

    await prefs.setStringList(_key, favorites.toList());
  }
}
