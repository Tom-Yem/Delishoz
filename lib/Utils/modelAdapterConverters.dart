//functions for converting service model
// to hive adapter and vice versa

import 'package:recipe_app/Search/Model/recipeModel.dart';
import 'package:recipe_app/hive_adapters/ingredient_adapter.dart';
import 'package:recipe_app/hive_adapters/recipe_adapter.dart';

// return hive adapter from recipe model
RecipeHive hiveFromModel(RecipeModel recipe) {
  return RecipeHive(
    id: recipe.id,
    image: recipe.image,
    title: recipe.title,
    instructions: recipe.instructions,
    youtubeVideo: recipe.youtubeVideo,
    ingredients: List.from(
      recipe.ingredients?.map(
            (Ingredient e) =>
                IngredientHive(ingredient: e.ingredient, measure: e.measure),
          ) ??
          [],
    ),
  );
}

// return recipe model from hive adapter
RecipeModel modelFromHive(RecipeHive recipe) {
  return RecipeModel(
    id: recipe.id,
    image: recipe.image,
    title: recipe.title,
    instructions: recipe.instructions,
    youtubeVideo: recipe.youtubeVideo,
    ingredients: List.from(
      recipe.ingredients?.map(
            (IngredientHive e) =>
                Ingredient(ingredient: e.ingredient, measure: e.measure),
          ) ??
          [],
    ),
  );
}
