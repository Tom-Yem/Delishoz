import 'package:hive/hive.dart';
import 'package:recipe_app/hive_adapters/ingredient_adapter.dart';

part 'recipe_adapter.g.dart';

@HiveType(typeId: 1)
class RecipeHive {
  RecipeHive(
      {this.id,
      this.title,
      this.instructions,
      this.image,
      this.youtubeVideo,
      this.ingredients});

  @HiveField(0)
  String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? instructions;
  @HiveField(3)
  String? image;
  @HiveField(4)
  String? youtubeVideo;
  @HiveField(5)
  List<IngredientHive>? ingredients;
}
