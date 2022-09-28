import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayVoiceMsg extends StatefulWidget {
  const PlayVoiceMsg({required this.audioMsgUrl, super.key});
  final String audioMsgUrl;

  @override
  State<PlayVoiceMsg> createState() => _PlayVoiceMsgState();
}

class _PlayVoiceMsgState extends State<PlayVoiceMsg> {
  bool isPlaying = false;
  AudioPlayer player = AudioPlayer();
  Duration duration = Duration.zero;
  Duration pos = Duration.zero;

  @override
  void initState() {
    // _init();
    super.initState();
  }

  // Future<void> _init() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                "https://1757140519.rsc.cdn77.org/blog/wp-content/uploads/2021/02/music-album-h-e1613595698579.jpg",
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text("Flutter song"),
          const SizedBox(height: 20),
          const Text("play song"),
          Slider(
            min: 0,
            max: duration.inSeconds.toDouble(),
            value: pos.inSeconds.toDouble(),
            onChanged: (val) async {},
          ),
          CircleAvatar(
            child: IconButton(
              icon: Icon(
                !isPlaying ? Icons.play_arrow : Icons.pause,
              ),
              onPressed: () async {
                if (isPlaying) {
                  await player.pause();
                } else {
                  await player.play(widget.audioMsgUrl);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
