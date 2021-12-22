import 'package:flutter/material.dart';
import 'package:get/get.dart';

// core modules
import 'package:recipe_app/Details/Details.dart';
import 'package:recipe_app/Details/DetailsDialog.dart';
import 'package:recipe_app/Search/Controller/recipeController.dart';

class RecipesPage extends StatelessWidget {
  final RecipeController recipeController = Get.put(RecipeController());
  final String? query;

  RecipesPage({Key? key, this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$query"),
      ),
      body: Obx(
        () {
          if (recipeController.isLoading.value)
            return Center(child: CircularProgressIndicator());
          else {
            return GridView.count(
                crossAxisCount:
                    MediaQuery.of(context).size.width <= 800 ? 2 : 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                children: [
                  for (int i = 0; i < recipeController.recipes.length; i++)
                    GestureDetector(
                      onTap: () {
                        bool isDesktop =
                            MediaQuery.of(context).size.width > 800;
                        (isDesktop)
                            ? showDialog(
                                context: context,
                                builder: (context) => DetailsDialog(
                                    recipe: recipeController.recipes[i]))
                            : Get.to(
                                Details(
                                  recipe: recipeController.recipes[i],
                                ),
                              );
                      },
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
