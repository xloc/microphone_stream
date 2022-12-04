import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'microphone_stream_platform_interface.dart';

/// An implementation of [MicrophoneStreamPlatform] that uses method channels.
class MethodChannelMicrophoneStream extends MicrophoneStreamPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('microphone_stream');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
