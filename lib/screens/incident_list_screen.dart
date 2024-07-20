import 'package:flutter/material.dart';
import 'package:seguridad_20185846/db/db_helper.dart';
import 'package:seguridad_20185846/models/incident.dart';
import 'package:seguridad_20185846/screens/add_incident_screen.dart';
import 'package:seguridad_20185846/screens/incident_detail_screen.dart';

class IncidentListScreen extends StatefulWidget {
  const IncidentListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _IncidentListScreenState createState() => _IncidentListScreenState();
}

class _IncidentListScreenState extends State<IncidentListScreen> {
  late Future<List<Incident>> _incidents;

  @override
  void initState() {
    super.initState();
    _incidents = DBHelper().getIncidents();
  }

  Future<void> _refreshIncidents() async {
    setState(() {
      _incidents = DBHelper().getIncidents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incidencias'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await DBHelper().deleteAllIncidents();
              await _refreshIncidents();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Incident>>(
        future: _incidents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay incidencias registradas.'));
          } else {
            final incidents = snapshot.data!;
            return ListView.builder(
              itemCount: incidents.length,
              itemBuilder: (context, index) {
                final incident = incidents[index];
                return ListTile(
                  title: Text(incident.title),
                  subtitle: Text(incident.date),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => IncidentDetailScreen(incident: incident),
                    ));
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddIncidentScreen()),
          ).then((_) => _refreshIncidents());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
