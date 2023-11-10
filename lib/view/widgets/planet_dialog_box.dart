import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:space_x/constants.dart';

class PlanetDialogBox extends StatelessWidget {
  const PlanetDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4.5, sigmaY: 4.5),
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _PlanetImageWidget(
                  planetImage: Constants.earthLogo,
                  planetName: 'Earth',
                  onTap: () => Navigator.pop(context, Constants.earthLogo),
                ),
                _PlanetImageWidget(
                  planetImage: Constants.moonLogo,
                  planetName: 'Moon',
                  onTap: () => Navigator.pop(context, Constants.moonLogo),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: _PlanetImageWidget(
                    planetImage: Constants.marsLogo,
                    planetName: 'Mars',
                    onTap: () => Navigator.pop(context, Constants.marsLogo),
                  ),
                ),
                _PlanetImageWidget(
                  planetImage: Constants.saturnLogo,
                  planetName: 'Saturn',
                  onTap: () => Navigator.pop(context, Constants.saturnLogo),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanetImageWidget extends StatelessWidget {
  final String planetImage;
  final String planetName;
  final void Function()? onTap;
  const _PlanetImageWidget({
    Key? key,
    required this.planetImage,
    required this.planetName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            planetImage,
            height: 60,
            width: 60,
          ),
          Text(
            planetName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}
