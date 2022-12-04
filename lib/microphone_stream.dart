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
    stream = _channel.receiveBroadcastStream().cast<Float32List>();
  }
}
