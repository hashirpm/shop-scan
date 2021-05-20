import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

abstract class ShowOverlay {
  static OverlayState? _overlayState;
  static OverlayEntry? _overlayEntry;
  static void overlay1(BuildContext context) {
    _overlayState = Overlay.of(context)!;
    _overlayEntry = OverlayEntry(
      builder: (context) => Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.black54),
        child: Center(
          child: SpinKitRing(
            color: Colors.white,
            size: 100,
          ),
        ),
      ),
    );

    _overlayState!.insert(_overlayEntry!);
  }

  static void stop() {
    _overlayEntry!.remove();
  }
}
