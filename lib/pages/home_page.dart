import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/incidencia.dart';
import '../services/database_service.dart';
import 'add_incidencia_page.dart';
import 'incidencia_detail_page.dart';
import 'about_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Incidencias'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Incidencia>>(
        future: Provider.of<DatabaseService>(context, listen: false).getIncidencias(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay incidencias registradas.'));
          } else {
            final incidencias = snapshot.data!;
            return ListView.builder(
              itemCount: incidencias.length,
              itemBuilder: (context, index) {
                final incidencia = incidencias[index];
                return ListTile(
                  title: Text(incidencia.title),
                  subtitle: Text(incidencia.date),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IncidenciaDetailPage(incidencia: incidencia),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddIncidenciaPage()),
          );
        },
      ),
    );
  }
}
