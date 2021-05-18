import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/Search/Controller/recipeController.dart';

class RecipesPage extends StatelessWidget {
  final RecipeController recipeController = Get.put(RecipeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Result")),
      body: Obx(
        () {
          if (recipeController.isLoading.value)
            return Center(child: CircularProgressIndicator());
          else {
            return GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                padding: EdgeInsets.symmetric(horizontal: 24),
                children: [
                  for (int i = 0; i < recipeController.recipes.length; i++)
                    GridTile(
                      child:
                          Image.network(recipeController.recipes[i]['image']),
                      // footer: GridTileBar(
                      //   title: Text(recipeController.recipes[i].label),
                      //   subtitle: Text(recipeController.recipes[i].label),
                      // ),
                    )
                ]);
          }
        },
      ),
    );
  }
}
