import 'package:get/get.dart';
import 'package:recipe_app/Search/Model/recipeModel.dart';
import 'package:recipe_app/Search/Model/stateView.dart';
import 'package:recipe_app/Search/Service/recipeService.dart';

class RecipeController extends GetxController {
  Rx<String> query = "chicken".obs;
  var recipes = RxList<RecipeModel>();
  Rx<StateView> status = Rx<StateView>(StateView.Loading);

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
}
