import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:microphone_stream/microphone_stream.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final micStream = MicrophoneStream();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Microphone Loudness Bars'),
        ),
        body: StreamBuilder(
          stream: micStream.stream,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container();
            }

            final data = snapshot.data!;
            return LoudnessScreen(data: data);
          },
        ),
      ),
    );
  }
}

class LoudnessScreen extends StatelessWidget {
  const LoudnessScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Float32List data;

  @override
  Widget build(BuildContext context) {
    final loudness = data.map((n) => n.abs()).average;
    final loudnessMax = data.max;

    return Column(
      children: [
        LoudnessBar(
          loudness: loudnessMax,
          color: Colors.amber,
          text: "max",
        ),
        LoudnessBar(loudness: loudness, color: Colors.green, text: "avg")
      ],
    );
  }
}

class LoudnessBar extends StatelessWidget {
  const LoudnessBar({
    Key? key,
    required this.loudness,
    required this.color,
    required this.text,
  }) : super(key: key);

  final double loudness;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: FractionallySizedBox(
        widthFactor: loudness + 0.1,
        child: Container(
          color: color,
          child: Center(child: Text(text)),
        ),
      ),
    );
  }
}
