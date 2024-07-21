import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/officer.jpg'),
            ),
            SizedBox(height: 10),
            Text(
              'Nombre: Juan Pérez',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Apellido: López',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Matrícula: 20185685',
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
