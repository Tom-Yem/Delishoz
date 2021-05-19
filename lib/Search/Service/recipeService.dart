import 'package:http/http.dart' as http;
import 'package:recipe_app/Search/Model/recipeModel.dart';

Future getRecipes({query}) async {
  var nonNullableQuery = (query == null || query.isEmpty) ? "chicken" : query;
  String baseUrl =
      'https://themealdb.com/api/json/v1/1/search.php?s=$nonNullableQuery';
  try {
    var uri = Uri.parse(baseUrl);
    print("uro:$uri");
    var response = await http.get(uri);
    // print("response:${response.body}");

    return recipeFromJson(response.body);
  } catch (ex) {
    throw ex;
  }
}
