import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/Search/Controller/recipeController.dart';
import 'package:recipe_app/Search/View/Recipes.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
    required this.recipeController,
  }) : super(key: key);

  final RecipeController recipeController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      onSubmitted: (input) {
        recipeController.searchMeal(input);
        Get.to(
          () => RecipesPage(),
        );
      },
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            size: 32,
            color: Colors.white,
          ),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          labelText: "Search",
          filled: true,
          fillColor: Colors.black54,
          labelStyle: TextStyle(color: Colors.white)),
    );
  }
}
