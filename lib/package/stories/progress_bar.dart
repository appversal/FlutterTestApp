import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({super.key, required this.percentWatched});
  final double percentWatched;

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      padding: EdgeInsets.symmetric(horizontal: 6),
      barRadius: Radius.circular(20),
      lineHeight: 3,
      percent: widget.percentWatched,
      progressColor: Color.fromARGB(255, 211, 202, 202),
      backgroundColor: Colors.grey[600],
    );
  }
}
