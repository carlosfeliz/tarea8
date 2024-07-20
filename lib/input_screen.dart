import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'location_provider.dart';

class InputScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  InputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrada de Datos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _surnameController,
                decoration: const InputDecoration(labelText: 'Apellido'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un apellido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _latitudeController,
                decoration: const InputDecoration(labelText: 'Latitud'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la latitud';
                  }
                  return null;
                },
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              TextFormField(
                controller: _longitudeController,
                decoration: const InputDecoration(labelText: 'Longitud'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la longitud';
                  }
                  return null;
                },
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final name = _nameController.text;
                    final surname = _surnameController.text;
                    final latitude = double.parse(_latitudeController.text);
                    final longitude = double.parse(_longitudeController.text);

                    Provider.of<LocationProvider>(context, listen: false).setLocation(
                      name: name,
                      surname: surname,
                      latitude: latitude,
                      longitude: longitude,
                    );

                    Navigator.pushNamed(context, '/map');
                  }
                },
                child: const Text('Siguiente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
