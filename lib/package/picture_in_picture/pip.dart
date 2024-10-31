import 'package:flutter/material.dart';
import 'package:piptest/package/picture_in_picture/lib/flutter_in_app_pip.dart';
import 'package:piptest/package/nil.dart';
import 'package:piptest/package/picture_in_picture/pip_page.dart';
import 'package:piptest/package/picture_in_picture/video_file.dart';

class PipOverlay extends StatefulWidget {
  final String smallVideoUrl;
  final String largeVideoUrl;
  final String pipUrl;
  const PipOverlay(
      {super.key,
      required this.smallVideoUrl,
      required this.largeVideoUrl,
      required this.pipUrl});

  @override
  State<PipOverlay> createState() => _PipOverlayState();
}

class _PipOverlayState extends State<PipOverlay> {
  @override
  void initState() {
    PictureInPicture.updatePiPParams(
        pipParams: const PiPParams(
      pipWindowHeight: 200,
      pipWindowWidth: 140,
      bottomSpace: 120,
      topSpace: 80,
    ));
    PictureInPicture.startPiP(
      pipWidget: PiPWidget(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PipPage(
                    largeVideoUrl: widget.largeVideoUrl,
                    pipUrl: widget.pipUrl,
                  )));
          PictureInPicture.stopPiP();
        },
        onPiPClose: () {},
        pipBorderRadius: 15,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: VideoFile(
                videoUrl: widget.smallVideoUrl,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  PictureInPicture.stopPiP();
                },
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 17,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return nil;
  }
}
