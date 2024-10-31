import 'package:flutter/material.dart';
import 'package:piptest/package/picture_in_picture/sample_page.dart';
import 'package:piptest/package/picture_in_picture/video_file.dart';
import 'package:url_launcher/url_launcher.dart';

class PipPage extends StatefulWidget {
  final String largeVideoUrl;
  final String pipUrl;
  const PipPage({super.key, required this.largeVideoUrl, required this.pipUrl});

  @override
  State<PipPage> createState() => _PipPageState();
}

class _PipPageState extends State<PipPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: VideoFile(
                videoUrl: widget.largeVideoUrl,
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  shadows: <Shadow>[
                    Shadow(
                      color: Colors.white,
                      blurRadius: 2,
                    ),
                  ],
                  Icons.close,
                  color: Colors.black,
                  size: 28,
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  const Spacer(
                    flex: 100,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (!await launchUrl(Uri.parse(widget.pipUrl))) {
                        throw Exception('Could not launch the url');
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: MediaQuery.of(context).size.width * 0.37),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Book Now',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
