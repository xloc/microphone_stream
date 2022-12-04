import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
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
          title: const Text('Plugin example app'),
        ),
        body: StreamBuilder(
          stream: micStream.stream,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container();
            }

            final data = snapshot.data!;
            return LoudnessBar(data: data);
          },
        ),
      ),
    );
  }
}

class LoudnessBar extends StatelessWidget {
  const LoudnessBar({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Float32List data;

  @override
  Widget build(BuildContext context) {
    // final double loudness = data.reduce(
    //   (value, element) {
    //     final abs = value.abs();
    //     return max(abs, value);
    //   },
    // );
    final loudness = data[0];

    return Center(
      child: Column(
        children: [
          Text("${loudness.toStringAsFixed(4)}"),
          Text(data.length.toString()),
        ],
      ),
    );
  }
}
