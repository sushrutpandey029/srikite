import 'package:flutter/material.dart';
import 'package:kite/chat/ui/widgets/image_view.dart';
import 'package:kite/chat/ui/widgets/voice_msg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:kite/shared/constants/url_constants.dart';

class MessageTileWidget extends StatelessWidget {
  MessageTileWidget(
      {Key? key,
      required this.type,
      required this.isByUser,
      required this.message,
      required this.time,
      required this.isContinue})
      : super(key: key);
  String message;
  String time;
  bool isByUser;
  bool isContinue;
  String type;

  Widget showMessage(BuildContext context, String type, String message) {
    print("Here");
    print(type);
    print(message);
    if (type == "image") {
      return _displayImage(context, message);
      // return Text("Hello");
    } else if (type == "audio") {
      // return Text(audioMsgUrl);
      return PlayVoiceMsg(audioMsgUrl: "$audioMsgUrl/$message", time: time);
      // return PlayAudioFromFile(audioMsgUrl: '$audioMsgUrl/$message');
    } else if (type == "contact") {
      return Text(
        'contact - $message',
        style: const TextStyle(color: Colors.red),
      );
    } else if (type == "location") {
      return Text('Location - $message');
    } else if (type == "file") {
      return Text("Document - $message");
    } else {
      int length = message.split("\n").length;
      if (length > 10) {
        List<String> splitText = message.split("\n");
        String shrinkText = "";
        for (int i = 0; i <= 9; i++) {
          shrinkText += splitText[i];
          if (i != splitText.length - 1) {
            shrinkText += "\n";
          }
        }
        return TextRenderWidget(
            fullText: message, shrinkText: shrinkText.trim());
      } else {
        return Text(message);
      }
    }
  }

  GestureDetector _displayImage(BuildContext context, String message) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          fullImageView(message),
        );
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14.sp),
            child: Image.network(
              '$imgMsgUrl/$message',
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Text(
              time,
              style: TextStyle(fontSize: 14.sp, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  MaterialPageRoute<dynamic> fullImageView(String message) {
    return MaterialPageRoute(
      builder: (context) => ImageView(
        imgUrl: '$imgMsgUrl/$message',
        isSendImage: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: isContinue ? 0.5.h : 1.5.h,
          bottom: 0.5.h,
          left: 1.w,
          right: 1.w),
      child: Row(
        mainAxisAlignment:
            isByUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (isByUser)
            SizedBox(
              width: 18.w,
            ),
          Flexible(
            child: Material(
              elevation: 3,
              color: isByUser
                  ? Colors.lightBlueAccent
                  : const Color.fromARGB(255, 236, 235, 235),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.sp)),
              child: Padding(
                padding: type == "image"
                    ? const EdgeInsets.all(4)
                    : EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                child: type == "text"
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: showMessage(context, type, message),
                          ),
                          // Text(message, style: TextStyle(fontSize: 16.sp))),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            time,
                            style: TextStyle(fontSize: 14.sp),
                          )
                        ],
                      )
                    : Expanded(
                        child: showMessage(context, type, message),
                      ),
              ),
            ),
          ),
          if (!isByUser)
            SizedBox(
              width: 18.w,
            ),
        ],
      ),
    );
  }
}

class TextRenderWidget extends StatefulWidget {
  const TextRenderWidget(
      {super.key, required this.fullText, required this.shrinkText});
  final String fullText;
  final String shrinkText;

  @override
  State<TextRenderWidget> createState() => _TextRenderWidgetState();
}

class _TextRenderWidgetState extends State<TextRenderWidget> {
  String toRenderText = '';

  @override
  void initState() {
    super.initState();
    toRenderText = widget.shrinkText;
  }

  void shrink() {
    toRenderText = widget.shrinkText;
  }

  void grow() {
    toRenderText = widget.fullText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(toRenderText),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: GestureDetector(
              onTap: () {
                setState(() {
                  if (toRenderText == widget.fullText) {
                    shrink();
                  } else {
                    grow();
                  }
                });
              },
              child: Text(
                toRenderText == widget.fullText ? "Show less" : "Show more",
                style: TextStyle(color: Colors.blue[700]),
              )),
        ),
      ],
    );
  }
}
