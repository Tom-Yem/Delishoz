import 'package:flutter/material.dart';
import 'package:get/get.dart';

// core modules
import 'package:recipe_app/Details/Details.dart';
import 'package:recipe_app/Search/Controller/recipeController.dart';

class RecipesPage extends StatelessWidget {
  final RecipeController recipeController = Get.put(RecipeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Result"),
      ),
      body: Obx(
        () {
          if (recipeController.isLoading.value)
            return Center(child: CircularProgressIndicator());
          else {
            return GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                padding: EdgeInsets.symmetric(horizontal: 8),
                children: [
                  for (int i = 0; i < recipeController.recipes.length; i++)
                    GestureDetector(
                      onTap: () => Get.to(
                        Details(
                          recipe: recipeController.recipes[i],
                        ),
                      ),
                      child: GridTile(
                        child: Hero(
                            tag: recipeController.recipes[i].id!,
                            child: Image.network(
                                recipeController.recipes[i].image!)),
                        //TODO: Find fallback image for this
                        footer: GridTileBar(
                          title: Text(recipeController.recipes[i].title ?? ""),
                          subtitle: Text("subtitle"),
                          backgroundColor: Colors.black54,
                          trailing: Icon(Icons.star, color: Colors.white60),
                        ),
                      ),
                    )
                ]);
          }
        },
      ),
    );
  }
}
