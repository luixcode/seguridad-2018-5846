import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acerca de')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/about-bg.jpg'),
            ),
            SizedBox(height: 20),
            Text('Nombre: Luis', style: TextStyle(fontSize: 18)),
            Text('Apellido: De la Rosa Minaya', style: TextStyle(fontSize: 18)),
            Text('Matrícula: 20185846', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text(
              'Reflexión: La vigilancia y la seguridad son pilares esenciales para el bienestar de nuestra comunidad.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
