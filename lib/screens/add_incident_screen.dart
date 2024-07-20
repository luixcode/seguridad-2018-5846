import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seguridad_20185846/models/incident.dart';
import 'package:seguridad_20185846/db/db_helper.dart';
import 'dart:io';

class AddIncidentScreen extends StatefulWidget {
  const AddIncidentScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddIncidentScreenState createState() => _AddIncidentScreenState();
}

class _AddIncidentScreenState extends State<AddIncidentScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late DateTime _selectedDate;
  File? _image;
  File? _audio;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickAudio() async {
    // Implement audio recording functionality
  }

  Future<void> _saveIncident() async {
    final newIncident = Incident(
      title: _titleController.text,
      date: _selectedDate.toString(),
      description: _descriptionController.text,
      photoPath: _image!.path,
      audioPath: _audio!.path,
    );
    await DBHelper().insertIncident(newIncident);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Incidencia')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Título')),
            TextField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Descripción')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _pickImage, child: const Text('Tomar Foto')),
            if (_image != null) Image.file(_image!),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _pickAudio, child: const Text('Grabar Audio')),
            if (_audio != null) const Text('Audio Grabado'),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _saveIncident, child: const Text('Guardar')),
          ],
        ),
      ),
    );
  }
}
