import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'microphone_stream_platform_interface.dart';

class AudioChannelMicrophoneStream extends MicrophoneStreamPlatform {
  final channel = const EventChannel('xloc.cc/microphone_stream');
}

class MicrophoneStream {
  final _channel = AudioChannelMicrophoneStream().channel;
  late Stream<Float32List> stream;

  MicrophoneStream() {
    final trunkStreamController = StreamController<Float32List>();
    _channel.receiveBroadcastStream().cast<Uint8List>().listen((trunk) {
      final list = trunk.buffer.asFloat32List();
      trunkStreamController.add(list);
    });
    stream = trunkStreamController.stream;
  }
}
