import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final String imgUrl;
  const ImageView({required this.imgUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Image View"),
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
    );
  }
}
