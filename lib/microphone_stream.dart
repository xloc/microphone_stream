import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AudioChannelMicrophoneStream {
  final channel = const EventChannel('xloc.cc/microphone_stream');
}

class MicrophoneStream {
  final _channel = AudioChannelMicrophoneStream().channel;

  /// The stream of audio. The samples are grouped into chunks
  late Stream<Float32List> stream;

  MicrophoneStream() {
    stream = _channel.receiveBroadcastStream().cast<Float32List>();
  }
}
