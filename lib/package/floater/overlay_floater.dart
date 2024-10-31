import 'package:flutter/material.dart';
import 'package:nil/nil.dart';
import 'package:url_launcher/url_launcher.dart';

OverlayEntry? entryBanner;

showFloaterOverlay(
    BuildContext context, String floaterImageUrl, String floaterUrl) {
  final overlayBanner = Overlay.of(context);

  entryBanner = OverlayEntry(
    builder: (context) => Positioned(
      right: 20,
      bottom: MediaQuery.of(context).size.height * 0.14,
      child: buildFloaterOverlay(context, floaterImageUrl, floaterUrl),
    ),
  );

  overlayBanner.insert(entryBanner!);
}

Widget buildFloaterOverlay(
        BuildContext context, String floaterImageUrl, String floaterUrl) =>
    Material(
      borderRadius:
          BorderRadius.circular((MediaQuery.sizeOf(context).height * 0.07) / 2),
      elevation: 8,
      child: InkWell(
        onTap: () async {
          if (!await launchUrl(Uri.parse(floaterUrl))) {
            throw Exception('Could not launch the url');
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
              (MediaQuery.sizeOf(context).height * 0.07) / 2),
          child: Image.network(
            fit: BoxFit.cover,
            height: MediaQuery.sizeOf(context).height * 0.07,
            // width: MediaQuery.sizeOf(context).width * 0.25,
            width: MediaQuery.sizeOf(context).height * 0.07,
            floaterImageUrl,
          ),
        ),
      ),
    );

class OverlayFloater extends StatefulWidget {
  final String floaterImageUrl;
  final String floaterUrl;
  const OverlayFloater(
      {super.key, required this.floaterImageUrl, required this.floaterUrl});

  @override
  State<OverlayFloater> createState() => _OverlayFloaterState();
}

class _OverlayFloaterState extends State<OverlayFloater> {
  @override
  void initState() {
    super.initState();
    // Show the banner overlay after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        showFloaterOverlay(context, widget.floaterImageUrl, widget.floaterUrl));
  }

  @override
  Widget build(BuildContext context) {
    return nil;
  }
}
