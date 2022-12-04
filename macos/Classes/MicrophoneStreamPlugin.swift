import Cocoa
import FlutterMacOS

import AVFoundation

public class MicrophoneStreamPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let instance = MicrophoneStreamPlugin()

    let micChannel = FlutterEventChannel(name: "xloc.cc/microphone_stream", binaryMessenger: registrar.messenger)
    micChannel.setStreamHandler(instance);

    let channel = FlutterMethodChannel(name: "microphone_stream", binaryMessenger: registrar.messenger)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    // case "getSampleRate":
    //   result(self.sampleRate)
    //   break;
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  var audioEngine = AVAudioEngine();
  var isRecording = false;

  public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    if (isRecording) {
      return nil; // should return error
    }
    isRecording = true;


    let input = audioEngine.inputNode
    let busID = 0
    let inputFormat = input.inputFormat(forBus: busID)

    input.installTap(onBus: busID, bufferSize: 512, format: inputFormat) { (buffer, time) in
      guard let channelData = buffer.floatChannelData?[0] else { return }

      let data = Data(buffer: UnsafeBufferPointer(start: channelData, count: Int(buffer.frameLength)))
      events(FlutterStandardTypedData(float32: data))
    }
    

    try! audioEngine.start()
    NSLog("audio engine started")

    return nil;
  }

  public func onCancel(withArguments arguments: Any?) -> FlutterError?  {
    NSLog("audio engine stopped");
    
    audioEngine.stop()
    audioEngine = AVAudioEngine()

    isRecording = false;
    return nil
  }
}
