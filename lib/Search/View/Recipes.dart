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
      body: Obx(
        () {
          if (recipeController.isLoading.value)
            return Center(child: CircularProgressIndicator());
          else {
            List recipes = recipeController.recipes;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.search,
                        size: 32,
                      ),
                    )
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${query?.capitalize}",
                          style:
                              Theme.of(context).textTheme.headline5?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          "${recipes.length} results found",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
                //     // TODO: Gridview can be upgraded from 'count' to 'builder'
                SliverGrid.count(
                  crossAxisCount:
                      MediaQuery.of(context).size.width <= 800 ? 2 : 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  children: [
                    for (int i = 0; i < recipes.length; i++)
                      GestureDetector(
                        onTap: () {
                          bool isDesktop =
                              MediaQuery.of(context).size.width > 800;
                          (isDesktop)
                              ? showDialog(
                                  context: context,
                                  builder: (context) =>
                                      DetailsDialog(recipe: recipes[i]))
                              : Get.to(
                                  Details(
                                    recipe: recipes[i],
                                  ),
                                );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: GridTile(
                            child: Hero(
                                tag: recipes[i].id!,
                                child: Image.network(recipes[i].image!)),
                            //TODO: Find fallback image for this
                            footer: GridTileBar(
                              title: Text(recipes[i].title ?? ""),
                              subtitle: Text("subtitle"),
                              backgroundColor: Colors.black54,
                              trailing: Icon(Icons.star, color: Colors.white60),
                            ),
                          ),
                        ),
                      )
                  ],
                )
              ],
            );
          }
        },
      ),
    );
  }
}
