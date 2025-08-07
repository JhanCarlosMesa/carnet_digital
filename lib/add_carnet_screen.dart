import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'carnet_model.dart';

class AddCarnetScreen extends StatefulWidget {
  final Carnet? carnetExistente;

  const AddCarnetScreen({super.key, this.carnetExistente});

  @override
  State<AddCarnetScreen> createState() => _AddCarnetScreenState();
}

class _AddCarnetScreenState extends State<AddCarnetScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _cedulaController = TextEditingController();
  File? _imagenSeleccionada;

  @override
  void initState() {
    super.initState();
    if (widget.carnetExistente != null) {
      _nombreController.text = widget.carnetExistente!.nombre;
      _apellidoController.text = widget.carnetExistente!.apellido;
      _cedulaController.text = widget.carnetExistente!.cedula;
      _imagenSeleccionada = File(widget.carnetExistente!.fotoPath);
    }
  }

  Future<void> _seleccionarImagen() async {
    final picker = ImagePicker();
    final imagen = await picker.pickImage(source: ImageSource.gallery);

    if (imagen != null) {
      final imagenRecortada = await ImageCropper().cropImage(
        sourcePath: imagen.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Recortar imagen',
            toolbarColor: Colors.deepPurple,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Recortar imagen',
          ),
        ],
      );

      if (imagenRecortada != null) {
        setState(() {
          _imagenSeleccionada = File(imagenRecortada.path);
        });
      }
    }
  }

  void _guardarCarnet() {
    if (_formKey.currentState!.validate() && _imagenSeleccionada != null) {
      final carnet = Carnet(
        nombre: _nombreController.text,
        apellido: _apellidoController.text,
        cedula: _cedulaController.text,
        fotoPath: _imagenSeleccionada!.path,
      );

      Navigator.pop(context, carnet);
    }
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.carnetExistente != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEdicion ? 'Editar Carnet' : 'Nuevo Carnet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _seleccionarImagen,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _imagenSeleccionada != null
                      ? FileImage(_imagenSeleccionada!)
                      : null,
                  child: _imagenSeleccionada == null
                      ? const Icon(Icons.add_a_photo, size: 30)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese un nombre' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _apellidoController,
                decoration: const InputDecoration(labelText: 'Apellido'),
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese un apellido' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _cedulaController,
                decoration: const InputDecoration(labelText: 'Cédula'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese una cédula';
                  } else if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'La cédula solo debe contener números';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _guardarCarnet,
                child: Text(esEdicion ? 'Guardar Cambios' : 'Crear Carnet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
