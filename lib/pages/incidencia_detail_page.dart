import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/incidencia.dart';

class IncidenciaDetailPage extends StatefulWidget {
  final Incidencia incidencia;

  const IncidenciaDetailPage({super.key, required this.incidencia});

  @override
  _IncidenciaDetailPageState createState() => _IncidenciaDetailPageState();
}

class _IncidenciaDetailPageState extends State<IncidenciaDetailPage> {
  final _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.incidencia.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.incidencia.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            if (widget.incidencia.photoPath.isNotEmpty)
              Image.file(File(widget.incidencia.photoPath)),
            const SizedBox(height: 10),
            if (widget.incidencia.audioPath.isNotEmpty)
              ElevatedButton(
                child: const Text('Reproducir Audio'),
                onPressed: () async {
                  try {
                    await _audioPlayer.setFilePath(widget.incidencia.audioPath);
                    _audioPlayer.play();
                  } catch (e) {
                    print("Error al reproducir audio: $e");
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
