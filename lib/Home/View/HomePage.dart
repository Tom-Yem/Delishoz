import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/Search/Controller/recipeController.dart';
import 'package:recipe_app/Search/View/Recipes.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({this.title});

  final String? title;
  final TextEditingController _controller = TextEditingController();
  final RecipeController recipeController = Get.put(RecipeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$title")),
      body: Center(
        child: Container(
          width: 500,
          height: 500,
          // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          child: Column(
            children: [
              Text("Search for your items here"),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Search",
                ),
              ),
              TextButton(
                onPressed: () {
                  recipeController.searchMeal(_controller.text);
                  // Get.toNamed("/search");
                  Get.to(RecipesPage());
                },
                child: Text("search"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
