import 'package:flutter/material.dart';

class QrPageClipper extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    var curXPos = 0.0;
    var curYPos = size.height;
    var increment = size.width / 25;

    while (curXPos < size.width) {
      curXPos += increment;
      path.arcToPoint(
        Offset(curXPos, curYPos),
        radius: const Radius.circular(5),
      );
    }

    path.lineTo(size.width, 0);

    // Left Round In
    path.addOval(
      Rect.fromCircle(
        center: Offset(0, (size.height / 8) * 1.8), // Position Roun In Left
        radius: 10, // Size
      ),
    );

    // Right Round In
    path.addOval(
      Rect.fromCircle(
        center: Offset(
            size.width, (size.height / 8) * 1.8), // Position Roun In Right
        radius: 10, // Size
      ),
    );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
