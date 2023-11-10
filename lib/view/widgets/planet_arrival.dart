class PlanetArrival {
  static const Map<String, Map<String, int>> time = {
    // dummy arrival date
    'Earth': {
      'Moon': 10,
      'Mars': 365,
      'Saturn': 550,
    },
    'Moon': {
      'Earth': 11,
      'Mars': 50,
      'Saturn': 600,
    },
    'Mars': {
      'Earth': 350,
      'Moon': 120,
      'Saturn': 600,
    },
    'Saturn': {
      'Earth': 500,
      'Moon': 655,
      'Mars': 996,
    },
  };
}
