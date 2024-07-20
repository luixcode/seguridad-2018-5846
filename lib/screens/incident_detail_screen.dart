import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:seguridad_20185846/models/incident.dart';
import 'dart:io';

class IncidentDetailScreen extends StatefulWidget {
  final Incident incident;

  const IncidentDetailScreen({super.key, required this.incident});

  @override
  // ignore: library_private_types_in_public_api
  _IncidentDetailScreenState createState() => _IncidentDetailScreenState();
}

class _IncidentDetailScreenState extends State<IncidentDetailScreen> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playPauseAudio() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(DeviceFileSource(widget.incident.audioPath));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.incident.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fecha: ${widget.incident.date}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            const Text('Descripción:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 5),
            Text(widget.incident.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            if (widget.incident.photoPath.isNotEmpty)
              Image.file(File(widget.incident.photoPath)),
            const SizedBox(height: 20),
            if (widget.incident.audioPath.isNotEmpty)
              Column(
                children: [
                  ElevatedButton(
                    onPressed: _playPauseAudio,
                    child: Text(isPlaying ? 'Detener Audio' : 'Detener'),
                  ),
                  Slider(
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    onChanged: (value) async {
                      final newPosition = Duration(seconds: value.toInt());
                      await _audioPlayer.seek(newPosition);
                      await _audioPlayer.resume();
                    },
                  ),
                  Text(
                    '${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')} / ${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
