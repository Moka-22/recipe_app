import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe/models/recipe_model.dart';
import 'package:recipe/service/shared_preference.dart';
import 'package:recipe/utils/colors.dart';

class AddRecipeView extends StatefulWidget {
  final Function onAdd;

  AddRecipeView({required this.onAdd});

  @override
  _AddRecipeViewState createState() => _AddRecipeViewState();
}

class _AddRecipeViewState extends State<AddRecipeView> {
  final _nameController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();
  String? _imagePath;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: AppColors.backGroundColor,
        title: Text(
          'Add Recipe',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    labelText: 'Recipe Name'),
              ),
              SizedBox(height: 10),
              TextField(
                maxLines: 5,
                controller: _ingredientsController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    labelText: 'Ingredients'),
              ),
              SizedBox(height: 10),
              TextField(
                maxLines: 5,
                controller: _stepsController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                    labelText: 'Steps'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backGroundColor,
                ),
                onPressed: _pickImage,
                child: Text(
                  'Pick Image',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backGroundColor,
                ),
                onPressed: () {
                  if (_nameController.text.isNotEmpty &&
                      _ingredientsController.text.isNotEmpty &&
                      _stepsController.text.isNotEmpty &&
                      _imagePath != null) {
                    Recipe recipe = Recipe(
                      name: _nameController.text,
                      imagePath: _imagePath!,
                      ingredients: _ingredientsController.text,
                      steps: _stepsController.text,
                    );

                    RecipeStorage storage = RecipeStorage();
                    storage.loadRecipes().then((recipes) {
                      recipes.add(recipe);
                      storage.saveRecipes(recipes).then((_) {
                        widget.onAdd();
                        Navigator.pop(context);
                      });
                    });
                  }
                },
                child: Text(
                  'Add Recipe',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
