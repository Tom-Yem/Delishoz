import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/Search/Model/recipeModel.dart';
import 'package:recipe_app/Search/Model/stateView.dart';
import 'package:recipe_app/Search/Service/recipeService.dart';
import 'package:recipe_app/Utils/modelAdapterConverters.dart';
import 'package:recipe_app/hive_adapters/ingredient_adapter.dart';

import '../../hive_adapters/recipe_adapter.dart';

class RecipeController extends GetxController {
  Rx<String> query = "chicken".obs;
  var recipes = RxList<RecipeModel>();
  var savedRecipes = RxList<RecipeModel>();
  Rx<StateView> status = Rx<StateView>(StateView.Loading);
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
      var allRecipes = await getRecipes(query: queryInput);
      recipes.assignAll(allRecipes);

      recipes.isEmpty ? status(StateView.Empty) : status(StateView.Success);
    } catch (ex) {
      status(StateView.Error);
      print("🧨🧨🧨Oppsi dozi, this error hit me:$ex🧨🧨🧨");
    }
  }

  void getSavedRecipes() async {
    status2(StateView.Loading);
    print("boxe fo saved${saved.values}");
    inspect(saved.get("saved_recipes"));

    List allSavedRecipes = saved.get("saved_recipes") ?? [];
    List<RecipeModel> convertedSavedRecipes =
        List.from(allSavedRecipes.map((e) => modelFromHive(e)));
    await Future.delayed(Duration(milliseconds: 1000));
    savedRecipes.assignAll(convertedSavedRecipes);
    status2(StateView.Success);
  }

  void saveRecipe(RecipeModel recipe) {
    saved.put(
      "saved_recipes",
      [hiveFromModel(recipe)],
    );
    inspect(saved.get("saved_recipes"));
    // savedRecipes.add(recipe);
  }
}
