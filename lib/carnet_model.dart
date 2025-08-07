import 'package:hive/hive.dart';

part 'carnet_model.g.dart';

@HiveType(typeId: 0)
class Carnet extends HiveObject {
  @HiveField(0)
  String nombre;

  @HiveField(1)
  String apellido;

  @HiveField(2)
  String cedula;

  @HiveField(3)
  String fotoPath;

  Carnet({
    required this.nombre,
    required this.apellido,
    required this.cedula,
    required this.fotoPath,
  });
}
