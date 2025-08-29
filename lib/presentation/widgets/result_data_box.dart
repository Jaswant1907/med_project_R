import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:io' show Platform;

class ResultDataBox extends StatefulWidget {
  final String apiText;

  const ResultDataBox({
    super.key,
    this.apiText =
        'This is a placeholder for a very long text fetched from an API. The new design allows this text to be viewed in a scrollable area...',
  });

  @override
  State<ResultDataBox> createState() => _ResultDataBoxState();
}

class _ResultDataBoxState extends State<ResultDataBox> {
  bool _isPlay = false;
  bool _isLoading = true;

  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    _initializeTts();

    // Simulate API delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _initializeTts() async {
    flutterTts = FlutterTts();

    // Set up completion handler that runs when speech is finished.
    // This resets the state to show the play button again.
    flutterTts.setCompletionHandler(() {
      if (mounted) {
        setState(() {
          _isPlay = false;
        });
      }
    });

    // Platform-specific configurations
    if (Platform.isAndroid) {
      // This is a common setting for Android to ensure completion handler is called.
      await flutterTts.awaitSpeakCompletion(true);
    }

    // Additional iOS settings for proper audio playback
    if (Platform.isIOS) {
      await flutterTts.setSharedInstance(true);
      await flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.playback,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers,
        ],
        IosTextToSpeechAudioMode.defaultMode,
      );
    }

    // Setting basic properties for TTS
    await flutterTts.setLanguage("en-US");
    // You can adjust the speech rate here (e.g., 0.5 is slower).
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
  }

  Future<void> _speak() async {
    if (widget.apiText.isNotEmpty) {
      // The await here ensures the function waits for the speech to complete.
      await flutterTts.speak(widget.apiText);
    }
  }

  Future<void> _stop() async {
    await flutterTts.stop();
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Top Info Box
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
            ),
            child: _isLoading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                            width: 100,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 15,
                            width: double.infinity,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 15,
                            width: double.infinity,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 15,
                            width: 200,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    ),
                  )
                : Column(
                    children: [
                      // Header Row
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text(
                              'Med info',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Row(
                              // Using an explicit spacing constant
                              children: [
                                IconButton(
                                  icon: Icon(
                                    _isPlay ? Icons.stop : Icons.play_arrow,
                                    size: 20,
                                  ),
                                  onPressed: () async {
                                    // The `await` keyword is now used to ensure the async calls complete.
                                    if (_isPlay) {
                                      await _stop();
                                    } else {
                                      await _speak();
                                    }
                                    setState(() {
                                      _isPlay = !_isPlay;
                                    });
                                  },
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.language, size: 20),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.apiText,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 12),
          // List Section
          SizedBox(
            height: 300,
            child: _isLoading
                ? ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: const ListTile(
                            title: Text('Cipladin'),
                            subtitle: Text('2.99'),
                            leading: CircleAvatar(
                              backgroundImage: AssetImage('assets/images/man2.jpg'),
                            ),
                            trailing: Icon(Icons.arrow_right),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
