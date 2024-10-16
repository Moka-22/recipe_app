import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe/features/add_recipe_page/presentation/views/add_recipe_view.dart';
import 'package:recipe/features/recipe_page_view/presentation/views/recipe_page_view.dart';
import 'package:recipe/models/recipe_model.dart';
import 'package:recipe/service/shared_preference.dart';
import 'package:recipe/utils/colors.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Recipe> recipes = [];
  List<Recipe> filteredRecipes = [];
  bool _isSearching = false;
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    RecipeStorage storage = RecipeStorage();
    List<Recipe> loadedRecipes = await storage.loadRecipes();
    setState(() {
      recipes = loadedRecipes;
      filteredRecipes = recipes;
    });
  }

  void _filterRecipes(String query) {
    List<Recipe> _filtered = recipes.where((recipe) {
      return recipe.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredRecipes = _filtered;
      _searchQuery = query;
    });
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        filteredRecipes = recipes;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: AppColors.backGroundColor,
        title: !_isSearching
            ? Text(
                'Recipe List',
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            : TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search Recipes...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: _filterRecipes,
              ),
        actions: [
          IconButton(
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: Colors.white,
            ),
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: filteredRecipes.isEmpty
            ? Center(child: Text('No Recipes Found'))
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 40,
                ),
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecipePageView(recipe: filteredRecipes[index]),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(
                                File(filteredRecipes[index].imagePath)),
                          ),
                          const SizedBox(height: 20),
                          Text(filteredRecipes[index].name),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.backGroundColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddRecipeView(onAdd: _loadRecipes),
            ),
          );
        },
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
