class Recipe {
  final String name;
  final String imagePath;
  final String ingredients;
  final String steps;

  Recipe(
      {required this.name,
      required this.imagePath,
      required this.ingredients,
      required this.steps});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imagePath': imagePath,
      'ingredients': ingredients,
      'steps': steps,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      name: map['name'],
      imagePath: map['imagePath'],
      ingredients: map['ingredients'],
      steps: map['steps'],
    );
  }
}
