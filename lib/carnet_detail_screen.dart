import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'carnet_model.dart';

class CarnetDetailScreen extends StatelessWidget {
  final Carnet carnet;

  const CarnetDetailScreen({super.key, required this.carnet});

  @override
  Widget build(BuildContext context) {
    final String qrData =
        '${carnet.nombre} ${carnet.apellido} - Cédula: ${carnet.cedula}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Carnet'),
        backgroundColor: const Color.fromARGB(255, 5, 134, 233),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(carnet.fotoPath),
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text('Nombre: ${carnet.nombre}', style: const TextStyle(fontSize: 18)),
              Text('Apellido: ${carnet.apellido}', style: const TextStyle(fontSize: 18)),
              Text('Cédula: ${carnet.cedula}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 30),
              const Text('Código QR del Carnet:', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 200.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
