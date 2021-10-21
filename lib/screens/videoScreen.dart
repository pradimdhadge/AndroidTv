import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final vUrl;
  VideoScreen(this.vUrl);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  var videoPlayerController;
  var chewieController;
  var _videoWidget;
  bool vinit = false;

  video() async {
    videoPlayerController = VideoPlayerController.network(widget.vUrl);

    await videoPlayerController.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: false,
      aspectRatio: 16 / 9,
      allowFullScreen: false,
    );

    _videoWidget = Chewie(
      controller: chewieController,
    );

    setState(() {
      vinit = true;
    });
  }

  @override
  void initState() {
    video();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: vinit
            ? _videoWidget
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
