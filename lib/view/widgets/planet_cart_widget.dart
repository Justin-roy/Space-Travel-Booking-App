import 'package:flutter/material.dart';

class PlanetCardWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final String planetName;
  final String planetImage;
  const PlanetCardWidget({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.planetName,
    required this.planetImage,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      padding: const EdgeInsets.all(4.0),
      width: size.width * 0.4,
      height: size.width * 0.28,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Image.asset(
                planetImage,
                height: 42,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                planetName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.expand_more_rounded,
                  size: 32,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
