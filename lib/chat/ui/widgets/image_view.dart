import 'package:flutter/material.dart';
import 'package:kite/chat/provider/chat_provider.dart';
import 'package:provider/provider.dart';

class ImageView extends StatelessWidget {
  final bool isSendImage;
  final String imgUrl;
  const ImageView({required this.imgUrl, required this.isSendImage, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Consumer<ChatProvider>(
          builder: (context, value, widget) {
            return Text(value.selectedUser!.userName);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.star_border_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Image.network(imgUrl),
            const Spacer(),
          ],
        ),
      ),
      floatingActionButton: isSendImage
          ? FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.send),
            )
          : null,
    );
  }
}
