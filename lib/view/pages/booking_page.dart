import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:space_x/bloc/common_bloc.dart';
import 'package:space_x/bloc/common_state.dart';
import 'package:space_x/view/pages/qr_ticket_page.dart';

import 'package:space_x/view/widgets/planet_bill_widget.dart';
import 'package:space_x/view/widgets/planet_cart_widget.dart';
import 'package:space_x/view/widgets/planet_dialog_box.dart';
import 'package:space_x/view/widgets/planet_vertical_divider.dart';

import '../widgets/planet_side_view_widget.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Card'),
      ),
      body: Stack(
        children: [
          _BookingPageViewWidget(
            onTap: () async {
              var navigator = Navigator.of(context);
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4.5, sigmaY: 4.5),
                  child: LottieBuilder.asset('assets/lottie/loader.json'),
                ),
              );
              await Future.delayed(
                const Duration(seconds: 6),
                () {
                  navigator.pop();
                  navigator.push(
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 700),
                      reverseTransitionDuration:
                          const Duration(milliseconds: 700),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const QrTicketPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          const PlanetSideViewWidget(),
        ],
      ),
    );
  }
}

class _BookingPageViewWidget extends StatelessWidget {
  final void Function()? onTap;
  const _BookingPageViewWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final bloc = context.read<CommonBloc>();
    return BlocBuilder<CommonBloc, CommonState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Planet Card
            Row(
              children: [
                const Spacer(
                  flex: 3,
                ),
                PlanetCardWidget(
                  label: 'From',
                  planetName: state.fromPlanetName,
                  planetImage: state.fromPlanetImg,
                  onPressed: () async {
                    var data = await showDialog(
                      context: context,
                      builder: (context) => const PlanetDialogBox(),
                    );
                    if (data != null) {
                      bloc.updateFromPlanetImg(data);
                      bloc.updatePlanetDistanceAndPrice();
                    }
                  },
                ),
                const Spacer(),
                PlanetCardWidget(
                  label: 'To',
                  planetName: state.toPlanetName,
                  planetImage: state.toPlanetImg,
                  onPressed: () async {
                    var data = await showDialog(
                      context: context,
                      builder: (context) => const PlanetDialogBox(),
                    );
                    if (data != null) {
                      bloc.updateToPlanetImg(data);
                      bloc.updatePlanetDistanceAndPrice();
                    }
                  },
                ),
                const Spacer(),
              ],
            ),
            // Planet Date
            Row(
              children: [
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        await bloc.updateDate(context);
                        bloc.updatePlanetArrivalDate();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Date',
                            style: TextStyle(color: Colors.white),
                          ),
                          Row(
                            children: [
                              Text(
                                state.selectedDate.split(' ')[0],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    state.selectedDate.split(' ')[1],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    state.selectedDate.split(' ')[2],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'No. of Persons',
                          style: TextStyle(color: Colors.white),
                        ),
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  int num = int.parse(state.numofPersons);
                                  num = num - 1;
                                  bloc.updateNoOfPersons(num.toString());
                                },
                                child: const Icon(Icons.arrow_back_ios,
                                    color: Colors.white)),
                            Text(
                              state.numofPersons,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                int num = int.parse(state.numofPersons);
                                num = num + 1;
                                bloc.updateNoOfPersons(num.toString());
                              },
                              child: const Icon(Icons.arrow_forward_ios,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Hero(
                  tag: 'rocket',
                  child: Image.asset(
                    'assets/images/rocket.png',
                    color: Colors.white,
                    height: size.width,
                    width: size.width * 0.55,
                  ),
                ),
              ],
            ),

            // Planet Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 10),
                PlanetBillWidget(
                  label: 'Price',
                  subTitle: '\$${state.distancePrice}',
                ),
                const PlanetVerticalDivider(),
                PlanetBillWidget(
                  label: 'Date of Arrival',
                  subTitle: state.arrivalDate,
                ),
                const PlanetVerticalDivider(),
                PlanetBillWidget(
                  label: 'Distance',
                  subTitle: state.distance,
                ),
              ],
            ),
            // Button

            InkWell(
              onTap: onTap,
              child: Container(
                width: size.width * 0.5,
                height: size.width * 0.14,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Center(
                  child: Text(
                    'Book Now',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
