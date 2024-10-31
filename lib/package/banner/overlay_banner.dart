import 'package:flutter/material.dart';
import 'package:nil/nil.dart';
import 'package:url_launcher/url_launcher.dart';

OverlayEntry? entryBanner;
OverlayEntry? entryClose;

// Method to show the banner with the close button
showBannerOverlay(
    BuildContext context, String bannerImageUrl, String bannerUrl) {
  // To show banner
  final overlayBanner = Overlay.of(context);

  entryBanner = OverlayEntry(
    builder: (context) => Positioned(
      right: 20,
      left: 20,
      bottom: MediaQuery.of(context).size.height * 0.14,
      child: buildBannerOverlay(context, bannerImageUrl, bannerUrl),
    ),
  );

  // To show close button
  final overlayClose = Overlay.of(context);

  overlayBanner.insert(entryBanner!);

  entryClose = OverlayEntry(
    builder: (context) => Positioned(
      right: 11,
      bottom: MediaQuery.of(context).size.height * 0.225,
      child: buildCloseOverlay(),
    ),
  );

  overlayClose.insert(entryClose!);
}

// Floating banner design
Widget buildBannerOverlay(
        BuildContext context, String bannerImageUrl, String bannerUrl) =>
    Material(
      elevation: 8,
      child: InkWell(
        onTap: () async {
          if (!await launchUrl(Uri.parse(bannerUrl))) {
            throw Exception('Could not launch the url');
          }
        },
        child: Image.network(
          fit: BoxFit.cover,
          height: MediaQuery.sizeOf(context).height * 0.1,
          bannerImageUrl,
        ),
      ),
    );

// Floating banner close icon design
Widget buildCloseOverlay() => GestureDetector(
      onTap: () {
        entryClose?.remove();
        entryBanner?.remove();
      },
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black,
        ),
        child: const Icon(
          Icons.close,
          color: Colors.white,
          size: 16,
        ),
      ),
    );

// Future<void> _launchUrl() async {
//   if (!await launchUrl(Uri.parse('https://flutter.dev'))) {
//     throw Exception('Could not launch the url');
//   }
// }

// banner.dart

class OverlayBanner extends StatefulWidget {
  final String bannerImageUrl;
  final String bannerUrl;
  const OverlayBanner(
      {super.key, required this.bannerImageUrl, required this.bannerUrl});

  @override
  State<OverlayBanner> createState() => _OverlayBannerState();
}

class _OverlayBannerState extends State<OverlayBanner> {
  @override
  void initState() {
    super.initState();
    // Show the banner overlay after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        showBannerOverlay(context, widget.bannerImageUrl, widget.bannerUrl));
  }

  @override
  Widget build(BuildContext context) {
    return nil;
  }
}
