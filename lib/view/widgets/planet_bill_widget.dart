import 'package:flutter/material.dart';

class PlanetBillWidget extends StatelessWidget {
  final String label;
  final String subTitle;
  const PlanetBillWidget({
    Key? key,
    required this.label,
    required this.subTitle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
        Text(
          subTitle,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
