import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'add_carnet_screen.dart';
import 'carnet_detail_screen.dart';
import 'carnet_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Box<Carnet> carnetBox = Hive.box<Carnet>('carnets');

  void _addCarnet(Carnet carnet) {
    carnetBox.add(carnet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Carnets Digitales'),
      ),
      body: ValueListenableBuilder(
        valueListenable: carnetBox.listenable(),
        builder: (context, Box<Carnet> box, _) {
          if (box.values.isEmpty) {
            return const Center(child: Text('No hay carnets aún.'));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final carnet = box.getAt(index)!;
              return ListTile(
                leading: Image.file(
                  File(carnet.fotoPath),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text('${carnet.nombre} ${carnet.apellido}'),
                subtitle: Text('Cédula: ${carnet.cedula}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CarnetDetailScreen(carnet: carnet),
                    ),
                  );
                },
                trailing: PopupMenuButton<String>(
                  onSelected: (value) async {
                    if (value == 'editar') {
                      final carnetEditado = await Navigator.push<Carnet>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddCarnetScreen(carnetExistente: carnet),
                        ),
                      );
                      if (carnetEditado != null) {
                        carnetBox.putAt(index, carnetEditado);
                      }
                    } else if (value == 'eliminar') {
                      await carnetBox.deleteAt(index);
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(value: 'editar', child: Text('Editar carnet')),
                    const PopupMenuItem(value: 'eliminar', child: Text('Eliminar carnet')),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final nuevoCarnet = await Navigator.push<Carnet>(
            context,
            MaterialPageRoute(builder: (_) => const AddCarnetScreen()),
          );
          if (nuevoCarnet != null) {
            _addCarnet(nuevoCarnet);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
