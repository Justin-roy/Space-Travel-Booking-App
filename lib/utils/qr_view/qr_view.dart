import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeCustomPainter extends CustomPainter {
  final String data;

  QRCodeCustomPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final qrPainter = QrPainter(
      data: data,
      color: Colors.white.withOpacity(0.8),
      gapless: false,
      version: QrVersions.auto,
    );

    final bounds =
        Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height));
    qrPainter.paint(canvas, bounds.size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
