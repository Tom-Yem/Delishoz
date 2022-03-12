import 'package:flutter/material.dart';
import 'package:recipe_app/Details/Details.dart';
import 'package:recipe_app/Details/widgets/IngredientTile.dart';
import 'package:recipe_app/Search/Model/recipeModel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class IngredientDetail extends StatelessWidget {
  const IngredientDetail({
    Key? key,
    required this.recipe,
    required YoutubePlayerController vidController,
  })  : _vidController = vidController,
        super(key: key);

  final RecipeModel recipe;
  final YoutubePlayerController _vidController;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ingredients",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ...?_renderIngredientsList(recipe, context),
            SizedBox(height: 24),
            Text(
              "Directions",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    recipe.instructions ?? "",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Container(
                  color: Colors.grey.shade400,
                  height: 40,
                  width: 4,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    color: Colors.grey.shade400,
                    height: 40,
                    width: 4,
                  ),
                )
              ],
            ),
            SizedBox(height: 24),
            Text("Video", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            YoutubePlayer(
              controller: _vidController,
            )
          ],
        ),
      ),
    );
  }
}

List? _renderIngredientsList(recipe, context) {
  return recipe.ingredients
      ?.map((ing) => IngredientTile(ingredientContainer: ing))
      .toList();
}
