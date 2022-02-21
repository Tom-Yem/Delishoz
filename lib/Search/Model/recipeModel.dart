import "dart:convert";

// TODO: Move this func into service
List transformMeal(decodedResponse) {
  var meals = decodedResponse["meals"];

  List<dynamic> getMealIngredients(meal) {
    var list = List.generate(20, (index) => index + 1);

    var ingredients = [];
    for (var item in list) {
      String ingredientKey = "strIngredient$item";
      String measureKey = "strMeasure$item";

      //check if ingredient is unavailable
      if (meal[ingredientKey] == null || meal[ingredientKey].isEmpty) continue;

      ingredients.add(
          {"ingredient": meal[ingredientKey], "measure": meal[measureKey]});
    }

    return ingredients;
  }

  return meals.map((meal) {
    var transformedMeal = {
      "id": meal["idMeal"],
      "title": meal["strMeal"],
      "instructions": meal["strInstructions"],
      "image": meal["strMealThumb"],
      "youtubeVideo": meal["strYoutube"],
      "ingredients": getMealIngredients(meal)
    };

    return transformedMeal;
  }).toList();
}

List<RecipeModel> recipeFromJson(json) {
  var decodedResponse = jsonDecode(json);
  var modifiedResponse = transformMeal(decodedResponse);
  // print("respo:$modifiedResponse");
  return modifiedResponse.map((resp) => RecipeModel.fromJson(resp)).toList();
}

class RecipeModel {
  String? id;
  String? title;
  String? instructions;
  String? image;
  String? youtubeVideo;
  bool isSaved = false;
  List<Ingredient>? ingredients;

  RecipeModel(
      {this.id,
      this.title,
      this.instructions,
      this.image,
      this.youtubeVideo,
      this.ingredients});

  RecipeModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        instructions = json["instructions"],
        image = json["image"],
        youtubeVideo = json["youtubeVideo"],
        ingredients = List<Ingredient>.from(json["ingredients"]
                ?.map((ingredient) => Ingredient.fromJson(ingredient)) ??
            []);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "instructions": instructions,
        "image": image,
        "youtubeVideo": youtubeVideo,
        "ingredients": List<dynamic>.from(
            ingredients?.map((ingredient) => ingredient.toJson()) ?? [])
      };
}

class Ingredient {
  String? ingredient;
  String? measure;

  Ingredient({this.ingredient, this.measure});

  Ingredient.fromJson(Map<String, dynamic> json)
      : ingredient = json['ingredient'],
        measure = json["measure"];

  Map<String, dynamic> toJson() =>
      {"ingredient": ingredient, "measure": measure};
}
