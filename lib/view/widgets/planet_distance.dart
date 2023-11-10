class PlanetDistances {
  static const Map<String, Map<String, String>> distances = {
    'Earth': {
      'Moon': '384,400 Kms',
      'Mars': '225 mln Kms',
      'Saturn': '1.417 bln kms',
    },
    'Moon': {
      'Earth': '384,400 Kms',
      'Mars': '56 mln kms',
      'Saturn': '18.4 mln kms',
    },
    'Mars': {
      'Earth': '225 mln kms',
      'Moon': '401.4 mln kms',
      'Saturn': '746 mln miles',
    },
    'Saturn': {
      'Earth': '1.417 bln',
      'Moon': '18.4 mln kms',
      'Mars': '744 mln miles',
    },
  };
}
