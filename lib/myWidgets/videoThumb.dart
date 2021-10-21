import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoTumbnail extends StatefulWidget {
  @override
  State<VideoTumbnail> createState() => _VideoTumbnailState();
}

class _VideoTumbnailState extends State<VideoTumbnail> {
  late VideoPlayerController _controller;
  bool isFocused = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onFocusChange: (f) {
        setState(() {
          isFocused = f;
        });
      },
      child: Container(
        constraints: BoxConstraints(maxHeight: 200, maxWidth: 300),
        padding: isFocused ? EdgeInsets.all(10) : null,
        decoration: isFocused
            ? BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 5,
                  style: BorderStyle.solid,
                ),
              )
            : null,
        child: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    children: [
                      VideoPlayer(_controller),
                      AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: Container(
                          color: Colors.blueAccent.withOpacity(0.3),
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Text(
                                'Lorem ipsum',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                'kljfsld klsdfj  jlksdfj lkjsdf jlkjsdadf l;kjlk;sdaf;lkj sdfl;kjsdf kljsdffoiuoiufr jklhsdfoiuhj kjkhkljha flkjjhkjll fkjhklsdff kjlhkjh',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                        ),
                      ),
                      if (isFocused)
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.blueAccent,
                              size: 70,
                            ),
                          ),
                        )
                    ],
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}
