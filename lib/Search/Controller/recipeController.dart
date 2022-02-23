import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/Search/Model/recipeModel.dart';
import 'package:recipe_app/Search/Model/stateView.dart';
import 'package:recipe_app/Search/Service/recipeService.dart';
import 'package:recipe_app/Utils/modelAdapterConverters.dart';

class RecipeController extends GetxController {
  Rx<String> query = "chicken".obs;
  var recipes = RxList<RecipeModel>();
  var savedRecipes = RxList<RecipeModel>();
  // status viewer for "recipes list" page
  Rx<StateView> status = Rx<StateView>(StateView.Loading);
  // status viewer for "saved recipes list" page
  Rx<StateView> status2 = Rx<StateView>(StateView.Loading);
  late Box saved;

  @override
  void onInit() {
    saved = Hive.box("saved");
    super.onInit();
  }

  void searchMeal(String queryInput) async {
    if (queryInput.isNotEmpty) query(queryInput);

    status(StateView.Loading);
    try {
      List<RecipeModel> allRecipes = await getRecipes(query: queryInput);

      if (savedRecipes.isEmpty) await getSavedRecipes();
      // check if there are saved recipes & mark them saved
      allRecipes = allRecipes.map((e) {
        bool isRecipeSaved = savedRecipes.any((element) => element.id == e.id);
        if (isRecipeSaved) e.isSaved = true;
        return e;
      }).toList();

      recipes.assignAll(allRecipes);
      recipes.isEmpty ? status(StateView.Empty) : status(StateView.Success);
    } catch (ex) {
      status(StateView.Error);
      print("🧨🧨🧨Oppsi dozi, this error hit me:$ex🧨🧨🧨");
    }
  }

  Future getSavedRecipes() async {
    status2(StateView.Loading);

    try {
      List allSavedRecipes = saved.get("saved_recipes") ?? [];
      List<RecipeModel> convertedSavedRecipes =
          List.from(allSavedRecipes.map((e) => modelFromHive(e)));

      // A short fake delay just for showing good loading ui
      await Future.delayed(Duration(milliseconds: 300));
      savedRecipes.assignAll(convertedSavedRecipes);

      savedRecipes.isEmpty
          ? status2(StateView.Empty)
          : status2(StateView.Success);
    } catch (ex) {
      status2(StateView.Error);
      print("OOPs error occured: $ex");
    }
  }

  void saveRecipe(RecipeModel recipe) {
    List alreadySavedRecipes = saved.get("saved_recipes") ?? [];
    // append to existing recipes
    alreadySavedRecipes.add(hiveFromModel(recipe));
    // find & mark saved recipes in recipes list
    List<RecipeModel> mappedRecipesList = recipes.map((element) {
      if (element.id == recipe.id) element.isSaved = true;
      return element;
    }).toList();

    saved.put(
      "saved_recipes",
      alreadySavedRecipes,
    );
    savedRecipes.add(recipe);
    recipes.assignAll(mappedRecipesList);
  }

  void unsaveRecipe(RecipeModel recipe) {
    List alreadySavedRecipes = saved.get("saved_recipes") ?? [];
    // remove from existing recipes
    if (alreadySavedRecipes.isNotEmpty)
      alreadySavedRecipes.removeWhere((element) => element.id == recipe.id);
    // find and unmark unsaved recipes in recipes list
    List<RecipeModel> mappedRecipesList = recipes.map((element) {
      if (element.id == recipe.id) element.isSaved = false;
      return element;
    }).toList();

    saved.put(
      "saved_recipes",
      alreadySavedRecipes,
    );
    savedRecipes.removeWhere((element) => element.id == recipe.id);
    recipes.assignAll(mappedRecipesList);
  }
}
