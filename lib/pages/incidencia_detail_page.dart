import 'dart:io';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/incidencia.dart';

class IncidenciaDetailPage extends StatelessWidget {
  final Incidencia incidencia;

  const IncidenciaDetailPage({super.key, required this.incidencia});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(incidencia.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              incidencia.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            if (incidencia.photoPath.isNotEmpty)
              Image.file(File(incidencia.photoPath)),
            const SizedBox(height: 10),
            if (incidencia.audioPath.isNotEmpty)
              ElevatedButton(
                child: const Text('Reproducir Audio'),
                onPressed: () {
                  AudioPlayer().play(DeviceFileSource(incidencia.audioPath));
                },
              ),
          ],
        ),
      ),
    );
  }
}
