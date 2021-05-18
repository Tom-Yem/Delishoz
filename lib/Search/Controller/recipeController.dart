import 'package:get/get.dart';
// import 'package:recipe_app/Search/Model/recipeModel.dart';
import 'package:recipe_app/Search/Service/recipeService.dart';

class RecipeController extends GetxController {
  RxBool isLoading = false.obs;
  var recipeCount = RxInt(0);
  var query = RxString("");
  var recipes = RxList();

  @override
  void onInit() {
    print("init of controller run");
    // handleGetRecipes();
    super.onInit();
  }

  void searchMeal(q) async {
    try {
      isLoading(true);
      var allRecipes = q.isEmpty
          ? await getRecipes()
          : await getRecipes(query: q); //TODO: this is ugly
      print("allRecipes:$allRecipes");
      // recipeCount(allRecipes.count);
      recipes.assignAll(allRecipes);
    } catch (ex) {
      print("Oppsi dozi, this error hit me:$ex");
    } finally {
      isLoading(false);
    }
  }

  void setSearchQuery(q) => query(q);
}
