import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'input_screen.dart';
import 'map_screen.dart';
import 'location_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocationProvider(),
      child: MaterialApp(
        title: 'Mapa de Localización',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => InputScreen(),
          '/map': (context) => const MapScreen(),
        },
      ),
    );
  }
}
