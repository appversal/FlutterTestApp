import 'package:flutter/material.dart';
import 'package:piptest/package/stories/progress_bar.dart';

class StoriesBar extends StatefulWidget {
  // List<double> percentWatched = [];
  double percentWatched;
  StoriesBar({super.key, required this.percentWatched});

  @override
  State<StoriesBar> createState() => _StoriesBarState();
}

class _StoriesBarState extends State<StoriesBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 6),
        child: Row(
          children: [
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: ProgressBar(percentWatched: widget.percentWatched),
            ),
            // Expanded(
            //   child: ProgressBar(percentWatched: widget.percentWatched[1]),
            // ),
            // Expanded(
            //   child: ProgressBar(percentWatched: widget.percentWatched[2]),
            // ),
            // Expanded(
            //   child: ProgressBar(percentWatched: widget.percentWatched[3]),
            // ),
            // Expanded(
            //   child: ProgressBar(percentWatched: widget.percentWatched[4]),
            // ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}
