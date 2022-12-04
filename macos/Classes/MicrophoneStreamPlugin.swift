import Cocoa
import FlutterMacOS

import AVFoundation

public class MicrophoneStreamPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let instance = MicrophoneStreamPlugin()

    let micChannel = FlutterEventChannel(name:"xloc.cc/microphone_stream", binaryMessenger: registrar.messenger)
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
    NSLog("listened")

    if (isRecording) {
      return nil; // should return error
    }
    isRecording = true;


    let input = audioEngine.inputNode
    let busID = 0
    let inputFormat = input.inputFormat(forBus: busID)

    NSLog("sampleRate = \(inputFormat.sampleRate)")
    NSLog("channelCount = \(inputFormat.channelCount)")
    // NSLog("channelLayout = \(inputFormat.channelLayout)")
    // NSLog("formatDescription = \(inputFormat.formatDescription)")


    input.installTap(onBus: busID, bufferSize: 512, format: inputFormat) { (buffer, time) in
      guard let channelData = buffer.floatChannelData?[0] else { return }

      var floatArray = Array(UnsafeBufferPointer(start: channelData, count: Int(buffer.frameLength)))
      // NSLog("\(intArray.count)")
      NSLog("\(buffer.frameLength)")

      floatArray.withUnsafeMutableBytes { unsafeMutableRawBufferPointer in
        let nBytes = Int(buffer.frameLength) * MemoryLayout<Float32>.size
        let unsafeMutableRawPointer = unsafeMutableRawBufferPointer.baseAddress!

        let data = Data(bytesNoCopy: unsafeMutableRawPointer, count: nBytes, deallocator: .none)
        events(FlutterStandardTypedData(bytes: data))
      }
    }
    try! audioEngine.start()

    return nil;
  }

  public func onCancel(withArguments arguments: Any?) -> FlutterError?  {
    NSLog("audio engine canceled");
    
    audioEngine.stop()
    audioEngine = AVAudioEngine()

    isRecording = false;
    return nil
  }
}
