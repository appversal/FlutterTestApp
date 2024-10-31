import 'package:flutter/material.dart';
import 'package:piptest/package/picture_in_picture/lib/pip_material_app.dart';
import 'package:piptest/package/picture_in_picture/lib/pip_params.dart';

class PictureInPicture {
  static bool isActive = false;
  static GlobalKey<PiPMaterialAppState> pipKey = GlobalKey();
  static void stopPiP() {
    pipKey.currentState?.changeOverlay();
    isActive = false;
  }

  static void startPiP({required Widget pipWidget}) {
    pipKey.currentState?.changeOverlay(overlay: pipWidget);
    isActive = true;
  }

  static void updatePiPParams({required PiPParams pipParams}) {
    pipKey.currentState?.updatePiPParams(pipParams: pipParams);
  }
}
