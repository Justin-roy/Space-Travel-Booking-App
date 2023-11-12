import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:space_x/constants.dart';
import 'package:space_x/view/widgets/planet_arrival.dart';
import 'package:space_x/view/widgets/planet_distance.dart';

import 'common_state.dart';

class CommonBloc extends Cubit<CommonState> {
  CommonBloc()
      : super(
          CommonState(
            fromPlanetImg: Constants.earthLogo,
            toPlanetImg: Constants.moonLogo,
            fromPlanetName: 'Earth',
            toPlanetName: 'Moon',
            numofPersons: '01',
            selectedDate: DateFormat('dd MMM y').format(DateTime.now()),
            distance: '384,400 Kms',
            distancePrice: '5000',
            arrivalDate: DateFormat('dd MMM y')
                .format(DateTime.now().add(const Duration(days: 10))),
            selectedOrg: 0,
          ),
        );

  final List<String> spaceOrganization = <String>['ISRO', 'NASA', 'Space X'];

  updateFromPlanetImg(String data) {
    String ext = data.split('/').last;
    String planetName = ext.replaceAll(r'.png', '');
    String filterData =
        planetName.replaceAll(planetName[0], planetName[0].toUpperCase());
    emit(state.copyWith(fromPlanetImg: data, fromPlanetName: filterData));
  }

  updateToPlanetImg(String data) {
    String ext = data.split('/').last;
    String planetName = ext.replaceAll(r'.png', '');
    String filterData =
        planetName.replaceAll(planetName[0], planetName[0].toUpperCase());
    emit(state.copyWith(toPlanetImg: data, toPlanetName: filterData));
  }

  updateNoOfPersons(String num) {
    if (num.length == 1) {
      num = "0$num";
    }
    if ((int.parse(num) > 0) && int.parse(num) <= 10) {
      emit(state.copyWith(numofPersons: num));
    }
  }

  Future<void> updateDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.dark(),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      String date = DateFormat('dd MMM y').format(picked);
      emit(state.copyWith(selectedDate: date));
    }
  }

  void updatePlanetDistanceAndPrice() {
    final fromPlanet = state.fromPlanetName;
    final toPlanet = state.toPlanetName;

    if (fromPlanet == toPlanet) {
      emit(state.copyWith(
        distance: '0 Kms',
        distancePrice: '00',
        arrivalDate: DateFormat('dd MMM y').format(DateTime.now()),
      ));
    }

    if (PlanetDistances.distances.containsKey(fromPlanet) &&
        PlanetDistances.distances[fromPlanet]!.containsKey(toPlanet)) {
      final distance = PlanetDistances.distances[fromPlanet]![toPlanet];
      _calculateDistancePrice();
      emit(state.copyWith(distance: distance));
      updatePlanetArrivalDate();
    }
  }

  void updatePlanetArrivalDate() {
    final fromPlanet = state.fromPlanetName;
    final toPlanet = state.toPlanetName;
    if (PlanetArrival.time.containsKey(fromPlanet) &&
        PlanetArrival.time[fromPlanet]!.containsKey(toPlanet)) {
      final time = PlanetArrival.time[fromPlanet]![toPlanet] as int;
      DateTime date = _convertStringToDate(state.selectedDate);
      emit(
        state.copyWith(
          arrivalDate: DateFormat('dd MMM y').format(
            date.add(
              Duration(days: time),
            ),
          ),
        ),
      );
    }
  }

  _convertStringToDate(String dateString) {
    try {
      DateFormat dateFormat = DateFormat("dd MMM y");
      DateTime date = dateFormat.parse(dateString);

      return date;
    } catch (e) {
      debugPrint("Error parsing date: $e");
    }
  }

  _calculateDistancePrice() {
    String price = '5000';
    String checkPriceSymbol = state.distance.split(' ').last;
    if (checkPriceSymbol == 'Kms') {
      emit(state.copyWith(distancePrice: price));
    }
    if (checkPriceSymbol == 'kms') {
      price = '10,500';
      emit(state.copyWith(distancePrice: price));
    } else {
      price = '50,500';
      emit(state.copyWith(distancePrice: price));
    }
  }

  int generateRandomNumber(int numberOfDigits) {
    int randomNumber = Random().nextInt(numberOfDigits);
    return randomNumber;
  }

  String getCompartmentNum() {
    int num = int.parse(state.numofPersons);
    List<String> randomNumbers = List.generate(
      num,
      (index) => generateRandomNumber(100).toString(),
    );

    return randomNumbers.join(', ');
  }

  Future<void> showOrganizationDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.5, sigmaY: 4.5),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).width,
              width: MediaQuery.sizeOf(context).width * 0.4,
              child: CupertinoPicker(
                backgroundColor: Colors.transparent,
                magnification: 1.22,
                useMagnifier: true,
                itemExtent: 120.0,
                scrollController: FixedExtentScrollController(
                  initialItem: 0,
                ),
                onSelectedItemChanged: (int selectedItem) {
                  emit(state.copyWith(selectedOrg: selectedItem));
                },
                children: List<Widget>.generate(
                  spaceOrganization.length,
                  (int index) {
                    return InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Center(
                        child: Text(
                          spaceOrganization[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2.5,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
