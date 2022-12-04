import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'microphone_stream_method_channel.dart';

abstract class MicrophoneStreamPlatform extends PlatformInterface {
  /// Constructs a MicrophoneStreamPlatform.
  MicrophoneStreamPlatform() : super(token: _token);

  static final Object _token = Object();

  static MicrophoneStreamPlatform _instance = MethodChannelMicrophoneStream();

  /// The default instance of [MicrophoneStreamPlatform] to use.
  ///
  /// Defaults to [MethodChannelMicrophoneStream].
  static MicrophoneStreamPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MicrophoneStreamPlatform] when
  /// they register themselves.
  static set instance(MicrophoneStreamPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
