import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kite/shared/constants/url_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PlayVoiceMsg extends StatefulWidget {
  const PlayVoiceMsg(
      {required this.audioMsgUrl, super.key, required this.time});
  final String audioMsgUrl;
  final String time;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  setState((() => isPlaying = !isPlaying));
                  print(audioMsgUrl);
                },
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow)),
            Expanded(
              child: Slider(
                value: 0,
                onChanged: (value) {},
              ),
            ),
            const CircleAvatar(
              radius: 20,
              child: Icon(Icons.person),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "1:10",
              style: TextStyle(fontSize: 14.sp),
            ),
            Text(
              widget.time,
              style: TextStyle(fontSize: 14.sp),
            ),
          ],
        )
      ],
    );
  }
}
