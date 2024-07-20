import 'package:flutter/material.dart';
import 'package:seguridad_20185846/screens/add_incident_screen.dart';
import 'package:seguridad_20185846/screens/incident_list_screen.dart';
import 'package:seguridad_20185846/screens/about_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seguridad 20185846',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: IncidentListScreen(),
      routes: {
        '/add': (context) => AddIncidentScreen(),
        '/about': (context) => AboutScreen(),
      },
    );
  }
}
