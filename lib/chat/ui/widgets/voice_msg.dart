import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kite/shared/constants/url_constants.dart';

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
    super.initState();
  }

  Future<void> _init() async {}
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
          onPressed: () {
            print(audioMsgUrl);
            // player.play();
          },
          icon: const Icon(Icons.play_arrow)),
      title: const Text("Voice msg"),
    );
  }
}
