import 'package:flutter_test/flutter_test.dart';
import 'package:microphone_stream/microphone_stream.dart';
import 'package:microphone_stream/microphone_stream_platform_interface.dart';
import 'package:microphone_stream/microphone_stream_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMicrophoneStreamPlatform
    with MockPlatformInterfaceMixin
    implements MicrophoneStreamPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MicrophoneStreamPlatform initialPlatform = MicrophoneStreamPlatform.instance;

  test('$MethodChannelMicrophoneStream is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMicrophoneStream>());
  });

  test('getPlatformVersion', () async {
    MicrophoneStream microphoneStreamPlugin = MicrophoneStream();
    MockMicrophoneStreamPlatform fakePlatform = MockMicrophoneStreamPlatform();
    MicrophoneStreamPlatform.instance = fakePlatform;

    expect(await microphoneStreamPlugin.getPlatformVersion(), '42');
  });
}
