# microphone_stream

A new Flutter plugin for acquiring audio stream on macOS. The implementation is based on AVAudioEngine. 

# Example

```dart
class _MyAppState extends State<MyApp> {
  final micStream = MicrophoneStream();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: StreamBuilder(
          stream: micStream.stream,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container();
            } else {
              final data = snapshot.data!;
              return Text("${data.max}");
            }
          },
        ),
      ),
    );
  }
}
```

see `example/lib/main.dart` for details

