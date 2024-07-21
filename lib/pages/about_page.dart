import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/officer.jpg'),
            ),
            SizedBox(height: 10),
            Text(
              'Nombre: Carlos Alberto',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Apellido: Feliz Recio',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Matrícula: 2021-2322',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Reflexión: La seguridad es nuestra prioridad, la vigilancia nuestra responsabilidad.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
