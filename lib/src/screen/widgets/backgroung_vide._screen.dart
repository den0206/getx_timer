import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [BackgroundVideoScreen(), child],
    );
  }
}

class BackgroundVideoScreen extends StatefulWidget {
  BackgroundVideoScreen({Key? key}) : super(key: key);

  @override
  _BackgroundVideoScreenState createState() => _BackgroundVideoScreenState();
}

class _BackgroundVideoScreenState extends State<BackgroundVideoScreen> {
  late VideoPlayerController _videoPlayerController;
  bool _visible = false;

  String getRandomVideo() {
    final random = math.Random();
    final i = random.nextInt(19) + 1;
    final videoPath = "assets/movie/training-$i.mp4";
    return videoPath;
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(getRandomVideo());
    _videoPlayerController.initialize().then((_) {
      _videoPlayerController.setLooping(true);
      setState(() {
        _videoPlayerController.play();

        _visible = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 1000),
      child: Stack(
        children: [
          VideoPlayer(_videoPlayerController),
          Container(color: Colors.black.withOpacity(0.5)),
        ],
      ),
    );
  }
}
