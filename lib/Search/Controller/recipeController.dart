import 'package:get/get.dart';
import 'package:recipe_app/Search/Model/recipeModel.dart';
import 'package:recipe_app/Search/Model/stateView.dart';
import 'package:recipe_app/Search/Service/recipeService.dart';

class RecipeController extends GetxController {
  RxBool isLoading = false.obs;
  var recipes = RxList<RecipeModel>();
  Rx<StateView> status = Rx<StateView>(StateView.Loading);

  void searchMeal(q) async {
    status(StateView.Loading);
    try {
      var allRecipes = await getRecipes(query: q);
      recipes.assignAll(allRecipes);

      recipes.isEmpty ? status(StateView.Empty) : status(StateView.Success);
    } catch (ex) {
      status(StateView.Error);
      print("🧨🧨🧨Oppsi dozi, this error hit me:$ex🧨🧨🧨");
    }
  }
}
