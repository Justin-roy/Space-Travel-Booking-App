import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_x/bloc/common_bloc.dart';
import 'package:space_x/bloc/common_state.dart';
import 'package:space_x/utils/clipper/page_clipper.dart';
import 'package:space_x/utils/qr_view/qr_view.dart';
import 'package:space_x/view/widgets/planet_bill_widget.dart';
import 'package:space_x/view/widgets/planet_side_view_widget.dart';
import 'package:space_x/view/widgets/planet_vertical_divider.dart';

class QrTicketPage extends StatelessWidget {
  const QrTicketPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Card'),
      ),
      body: Stack(
        children: [
          _QrTicketPageViewWidget(),
          const PlanetSideViewWidget(),
        ],
      ),
    );
  }
}

class _QrTicketPageViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final bloc = context.read<CommonBloc>();
    return BlocBuilder<CommonBloc, CommonState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Booking Confirmed',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Center(
              child: ClipPath(
                clipper: QrPageClipper(),
                child: Container(
                  width: size.width * 0.82,
                  height: size.width * 1.4,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Ticket No. ${bloc.generateRandomNumber(101541515)}',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Starship ${bloc.generateRandomNumber(10000)}',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      CustomPaint(
                        size: const Size(200, 200),
                        painter: QRCodeCustomPainter('Justin Roy'),
                      ),
                      Text(
                        '${state.fromPlanetName} to ${state.toPlanetName} // ${state.arrivalDate}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        '${state.numofPersons} Persons',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Compartment No. ${bloc.getCompartmentNum()}',
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          PlanetBillWidget(
                            label: 'Price',
                            subTitle:
                                '\$${state.distancePrice} X ${state.numofPersons}',
                          ),
                          const PlanetVerticalDivider(),
                          PlanetBillWidget(
                            label: 'D.O.A',
                            subTitle: state.arrivalDate,
                          ),
                          const PlanetVerticalDivider(),
                          PlanetBillWidget(
                            label: 'Distance',
                            subTitle: state.distance,
                          ),
                        ],
                      ),
                    ],
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
