// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IngredientHiveAdapter extends TypeAdapter<IngredientHive> {
  @override
  final int typeId = 2;

  @override
  IngredientHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IngredientHive(
      ingredient: fields[0] as String?,
      measure: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, IngredientHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.ingredient)
      ..writeByte(1)
      ..write(obj.measure);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
