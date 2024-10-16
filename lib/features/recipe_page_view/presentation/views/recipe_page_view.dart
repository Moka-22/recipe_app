import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe/models/recipe_model.dart';
import 'package:recipe/utils/colors.dart';

class RecipePageView extends StatelessWidget {
  final Recipe recipe;

  RecipePageView({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: AppColors.backGroundColor,
        title: Text(
          recipe.name,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  height: 500,
                  child: Image.file(File(recipe.imagePath))),
              SizedBox(height: 10),
              Text('Ingredients',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(recipe.ingredients),
              SizedBox(height: 10),
              Text('Steps',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(recipe.steps),
            ],
          ),
        ),
      ),
    );
  }
}
