import "dart:convert";

RecipeModel recipeFromJson(json) {
  var decodedResponse = jsonDecode(json);
  Map<String, dynamic> modifiedResponse = {
    "count": decodedResponse["count"],
    "hits": decodedResponse["hits"].map((hit) {
      var recipe = hit["recipe"];
      return {
        "uri": recipe["uri"],
        "label": recipe["label"],
        "image": recipe["image"]
      };
    }).toList()
  };
  print("respo:$modifiedResponse");
  return RecipeModel.fromJson(modifiedResponse);
}

class RecipeModel {
  // String q;
  int count;
  List<Hit> hits;

  RecipeModel({required this.count, required this.hits});

  RecipeModel.fromJson(Map<String, dynamic> json)
      : count = json["count"],
        hits = List<Hit>.from(json["hits"].map((hit) => Hit.fromJson(hit)));

  Map<String, dynamic> toJson() => {
        "count": count,
        "hits": List<dynamic>.from(hits.map((hit) => hit.toJson()))
      };
}

class Hit {
  String uri;
  String label;
  String image;

  Hit({required this.uri, required this.image, required this.label});

  Hit.fromJson(Map<String, dynamic> json)
      : uri = json['uri'],
        label = json["label"],
        image = json["image"];

  Map<String, dynamic> toJson() => {"uri": uri, "label": label, "image": image};
}
