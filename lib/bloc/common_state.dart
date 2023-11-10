class CommonState {
  final String fromPlanetImg;
  final String toPlanetImg;
  final String fromPlanetName;
  final String toPlanetName;
  final String numofPersons;
  final String selectedDate;
  final int selectedOrg;
  final String arrivalDate;
  final String distance;
  final String distancePrice;
  CommonState({
    required this.fromPlanetImg,
    required this.toPlanetImg,
    required this.fromPlanetName,
    required this.toPlanetName,
    required this.numofPersons,
    required this.selectedDate,
    required this.selectedOrg,
    required this.arrivalDate,
    required this.distance,
    required this.distancePrice,
  });

  CommonState copyWith({
    String? fromPlanetImg,
    String? toPlanetImg,
    String? fromPlanetName,
    String? toPlanetName,
    String? numofPersons,
    String? selectedDate,
    int? selectedOrg,
    String? arrivalDate,
    String? distance,
    String? distancePrice,
  }) {
    return CommonState(
      fromPlanetImg: fromPlanetImg ?? this.fromPlanetImg,
      toPlanetImg: toPlanetImg ?? this.toPlanetImg,
      fromPlanetName: fromPlanetName ?? this.fromPlanetName,
      toPlanetName: toPlanetName ?? this.toPlanetName,
      numofPersons: numofPersons ?? this.numofPersons,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedOrg: selectedOrg ?? this.selectedOrg,
      arrivalDate: arrivalDate ?? this.arrivalDate,
      distance: distance ?? this.distance,
      distancePrice: distancePrice ?? this.distancePrice,
    );
  }
}
