import 'package:get/get.dart';
import 'package:recipe_app/Search/Model/recipeModel.dart';
import 'package:recipe_app/Search/Service/recipeService.dart';

class RecipeController extends GetxController {
  RxBool isLoading = false.obs;
  var recipes = RxList<RecipeModel>();

  void searchMeal(q) async {
    try {
      isLoading(true);
      var allRecipes = await getRecipes(query: q);
      print("allRecipes:$allRecipes");
      recipes.assignAll(allRecipes);
    } catch (ex) {
      print("🧨🧨🧨Oppsi dozi, this error hit me:$ex🧨🧨🧨");
    } finally {
      isLoading(false);
    }
  }
}
