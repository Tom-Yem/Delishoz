import 'package:hive/hive.dart';

part 'ingredient_adapter.g.dart';

@HiveType(typeId: 2)
class IngredientHive {
  IngredientHive({
    this.ingredient,
    this.measure,
  });

  @HiveField(0)
  String? ingredient;
  @HiveField(1)
  String? measure;
}
