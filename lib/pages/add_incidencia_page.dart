import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:record/record.dart';
import '../models/incidencia.dart';
import '../services/database_service.dart';

class AddIncidenciaPage extends StatefulWidget {
  const AddIncidenciaPage({super.key});

  @override
  _AddIncidenciaPageState createState() => _AddIncidenciaPageState();
}

class _AddIncidenciaPageState extends State<AddIncidenciaPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  final String _date = DateTime.now().toIso8601String();
  File? _photo;
  File? _audio;
  final _recorder = Record(); // Crear una instancia de Record

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Incidencia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Título'),
                onSaved: (value) {
                  _title = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingrese un título';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descripción'),
                onSaved: (value) {
                  _description = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                child: const Text('Seleccionar Foto'),
                onPressed: () async {
                  final picker = ImagePicker();
                  final pickedFile = await picker.getImage(source: ImageSource.camera);
                  setState(() {
                    _photo = File(pickedFile!.path);
                  });
                },
              ),
              ElevatedButton(
                child: const Text('Seleccionar Audio'),
                onPressed: () async {
                  if (await _recorder.hasPermission()) {
                    await _recorder.start(
                      path: 'audio_${DateTime.now().millisecondsSinceEpoch}.m4a',
                      encoder: AudioEncoder.aacLc, // Usar AudioEncoder.aacLc
                      bitRate: 128000,
                      samplingRate: 44100,
                    );
                    setState(() {});
                  }
                },
              ),
              ElevatedButton(
                child: const Text('Detener Grabación'),
                onPressed: () async {
                  final path = await _recorder.stop();
                  setState(() {
                    _audio = File(path!);
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Guardar Incidencia'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newIncidencia = Incidencia(
                      title: _title,
                      description: _description,
                      date: _date,
                      photoPath: _photo?.path ?? '',
                      audioPath: _audio?.path ?? '',
                    );
                    Provider.of<DatabaseService>(context, listen: false).insertIncidencia(newIncidencia);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
