import 'package:flutter/material.dart';

// recipe model
import 'package:recipe_app/Search/Model/recipeModel.dart';

class Details extends StatelessWidget {
  final RecipeModel recipe;

  Details({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title ?? ""),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: recipe.id!,
                transitionOnUserGestures: true,
                child: Image.network(
                  //TODO: put fallback image here
                  recipe.image!,
                  fit: BoxFit.cover,
                  height: 250,
                  width: 500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Ingredients:",
                              style: Theme.of(context).textTheme.headline5),
                          SizedBox(height: 8),
                          ...?_renderIngredientsList(recipe),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Instructions:",
                              style: Theme.of(context).textTheme.headline5),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(recipe.instructions ?? "",
                                style: Theme.of(context).textTheme.bodyText1),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Video:",
                              style: Theme.of(context).textTheme.headline5),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(recipe.youtubeVideo ?? "",
                                style: Theme.of(context).textTheme.bodyText1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List? _renderIngredientsList(recipe) {
  return recipe.ingredients
      ?.map((ing) => ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://themealdb.com/images/ingredients/${ing.ingredient}.png"),
            ),
            title: Text(ing.ingredient ?? ""),
            subtitle: Text(ing.measure ?? ""),
          ))
      .toList();
}
