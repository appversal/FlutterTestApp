import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoFile extends StatefulWidget {
  const VideoFile({super.key, required this.videoUrl});
  final String videoUrl;

  @override
  State<VideoFile> createState() => _VideoFileState();
}

class _VideoFileState extends State<VideoFile> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayer;

  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );
    _initializeVideoPlayer = _controller.initialize();
    _controller.play();
    _controller.setVolume(0);
    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeVideoPlayer,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return VideoPlayer(
              _controller,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if (_controller.value.isPlaying) {
      //       _controller.pause();
      //       _controller.setLooping(true);
      //     } else {
      //       _controller.play();
      //     }
      //     setState(() {});
      //   },
      //   child: Icon(
      //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ),
    );
  }
}
