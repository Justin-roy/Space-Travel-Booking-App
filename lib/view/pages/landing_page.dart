import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:space_x/bloc/common_bloc.dart';
import 'package:space_x/view/pages/booking_page.dart';

import 'package:space_x/view/widgets/planet_side_view_widget.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<CommonBloc>().showOrganizationDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Card'),
      ),
      body: Stack(
        children: [
          _LandingViewWidget(
            onLongPress: () => Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 700),
                  reverseTransitionDuration: const Duration(milliseconds: 700),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const BookingPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                ),
                (route) => false),
          ),
          const PlanetSideViewWidget(),
        ],
      ),
    );
  }
}

class _LandingViewWidget extends StatelessWidget {
  final void Function()? onLongPress;
  const _LandingViewWidget({
    Key? key,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _RocketImageWidget(),
        InkWell(
          onLongPress: onLongPress,
          child: Stack(
            alignment: Alignment.center,
            children: [
              LottieBuilder.asset(
                'assets/lottie/finger_lodder.json',
                height: 100,
              ),
              Opacity(
                opacity: 0.5,
                child: Image.asset(
                  'assets/images/fingerprint.png',
                  color: Colors.white,
                  height: 65,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RocketImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return SizedBox(
      height: size.width * 1.4,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Hero(
              tag: 'rocket',
              child: Image.asset(
                'assets/images/rocket.png',
                color: Colors.white,
                height: size.width,
              ),
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: -15,
            child: LottieBuilder.asset(
              'assets/lottie/rocket_booster.json',
            ),
          ),
        ],
      ),
    );
  }
}
