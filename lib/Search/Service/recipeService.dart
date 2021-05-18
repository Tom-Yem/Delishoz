import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipe_app/Search/Model/recipeModel.dart';

Future getRecipes({query = "chicken"}) async {
  String baseUrl = 'https://themealdb.com/api/json/v1/1/search.php?s=$query';
  try {
    var uri = Uri.parse(baseUrl);
    print("uro:$uri");
    var response = await http.get(uri);
    print("response:${response.body}");
    var decoded = jsonDecode(response.body);
    print("decoded:$decoded");
    var modified = decoded['meals']
        .map((meal) => {"image": meal["strMealThumb"]})
        .toList();
    print("modified:$modified");

    return modified;
  } catch (ex) {
    throw ex;
  }
}
