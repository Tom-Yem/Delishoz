// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeHiveAdapter extends TypeAdapter<RecipeHive> {
  @override
  final int typeId = 1;

  @override
  RecipeHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeHive(
      id: fields[0] as String?,
      title: fields[1] as String?,
      instructions: fields[2] as String?,
      image: fields[3] as String?,
      youtubeVideo: fields[4] as String?,
      ingredients: (fields[5] as List?)?.cast<IngredientHive>(),
    );
  }

  @override
  void write(BinaryWriter writer, RecipeHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.instructions)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.youtubeVideo)
      ..writeByte(5)
      ..write(obj.ingredients);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
