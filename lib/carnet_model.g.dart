// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carnet_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarnetAdapter extends TypeAdapter<Carnet> {
  @override
  final int typeId = 0;

  @override
  Carnet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Carnet(
      nombre: fields[0] as String,
      apellido: fields[1] as String,
      cedula: fields[2] as String,
      fotoPath: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Carnet obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.apellido)
      ..writeByte(2)
      ..write(obj.cedula)
      ..writeByte(3)
      ..write(obj.fotoPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarnetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
