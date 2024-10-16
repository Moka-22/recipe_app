import 'package:recipe/models/recipe_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RecipeStorage {
  static const String _key = "recipes";

  Future<void> saveRecipes(List<Recipe> recipes) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> recipeList =
        recipes.map((recipe) => json.encode(recipe.toMap())).toList();
    await prefs.setStringList(_key, recipeList);
  }

  Future<List<Recipe>> loadRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? recipeList = prefs.getStringList(_key);
    if (recipeList != null) {
      return recipeList
          .map((recipe) => Recipe.fromMap(json.decode(recipe)))
          .toList();
    } else {
      return [];
    }
  }
}
