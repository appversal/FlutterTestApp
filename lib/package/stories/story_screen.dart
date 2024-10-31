import 'dart:async';
import 'package:flutter/material.dart';
import 'package:piptest/package/stories/stories_bar.dart';
import 'package:piptest/package/stories/story_var.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({
    super.key,
    required this.currentStory,
  });
  final int currentStory;

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final Uri _url = Uri.parse('https://flutter.dev');
  late int currentStory;
  double percentWatched = 0;
  VideoPlayerController? _videoController; // Video controller
  Timer? _progressTimer;
  bool isVideo = false; // Check if current story is video
  bool isLoading = true; // Loading state
  bool hasError = false; // Error state

  @override
  void initState() {
    super.initState();
    currentStory = widget.currentStory;
    _startWatching();
  }

  @override
  void dispose() {
    _videoController?.dispose(); // Dispose video controller
    _progressTimer?.cancel(); // Cancel timer
    super.dispose();
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  void _startWatching() {
    final currentMedia = storyMedia[currentStory];
    if (isVideoMedia(currentMedia)) {
      _playVideo(currentMedia);
    } else {
      setState(() {
        isVideo = false; // Set to false for images
        _startProgressTimer(
            duration: const Duration(seconds: 5)); // 5 seconds for images
      });
    }
  }

  bool isVideoMedia(String mediaUrl) {
    return mediaUrl.endsWith('.mp4'); // Checks if the media is a video
  }

  void _playVideo(String videoUrl) {
    setState(() {
      isLoading = true; // Show loading state
      hasError = false; // Reset error state
    });

    _videoController?.dispose(); // Dispose previous controller if any

    _videoController = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {
          isVideo = true; // Set to true for videos
          isLoading = false; // Hide loading state
          _videoController!.play();
          _startProgressTimer(duration: _videoController!.value.duration);
        });
      }).catchError((error) {
        // Error handling if video fails to load
        setState(() {
          isLoading = false;
          hasError = true; // Show error state
        });
        print("Error loading video: $error");
      });
  }

  void _startProgressTimer({required Duration duration}) {
    _progressTimer?.cancel(); // Cancel any existing timer

    _progressTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        final double step = 0.01 * (5000 / duration.inMilliseconds);
        if (percentWatched + step < 1) {
          percentWatched += step;
        } else {
          percentWatched = 0;
          timer.cancel();

          if (currentStory < storyMedia.length - 1) {
            currentStory++;
            _startWatching();
          } else {
            Navigator.pop(context);
          }
        }
      });
    });
  }

  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    if (dx < screenWidth / 3) {
      setState(() {
        if (currentStory > 0) {
          percentWatched = 0;
          currentStory--;
          _startWatching();
        }
      });
    } else if (dx > screenWidth / 1.5) {
      setState(() {
        if (currentStory < storyMedia.length - 1) {
          percentWatched = 0;
          currentStory++;
          _startWatching();
        } else {
          percentWatched = 1;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('story_screen_dismissible'),
      direction: DismissDirection.down,
      onDismissed: (_) {
        Navigator.pop(context);
      },
      child: GestureDetector(
        onTapDown: (details) => _onTapDown(details),
        child: Scaffold(
          body: Container(
            color: Colors.black,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02,
            ),
            child: Stack(
              children: [
                SafeArea(
                  child: Scaffold(
                    backgroundColor: Colors.black,
                    body: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.075,
                          ),
                          height: double.infinity,
                          width: double.infinity,
                          child: isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : hasError
                                  ? Center(
                                      child: Text(
                                        'Failed to load video',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    )
                                  : isVideo &&
                                          _videoController != null &&
                                          _videoController!.value.isInitialized
                                      ? AspectRatio(
                                          aspectRatio: _videoController!
                                              .value.aspectRatio,
                                          child: VideoPlayer(_videoController!),
                                        )
                                      : Image.network(
                                          fit: BoxFit.fill,
                                          storyMedia[
                                              currentStory], // Show image
                                        ),
                        ),
                        Positioned(
                          top: 22,
                          left: 20,
                          right: 20,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  width: 40,
                                  storyCircleImages[currentStory],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                storyCircleNames[currentStory],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  await Share.share('text');
                                },
                                child: const Icon(
                                  Icons.share,
                                  size: 26,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 6),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.close_rounded,
                                  size: 32,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: MediaQuery.of(context).size.height * 0.012,
                          right: MediaQuery.of(context).size.width / 2 - 76,
                          child: InkWell(
                            onTap: _launchUrl,
                            child: Container(
                              width: 152,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Continue to site',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                StoriesBar(
                  percentWatched: percentWatched,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
