const String homeRoute = '/';
const String eventDetailRoute = '/eventDetail';
const String eventPeopleListRoute = '/eventPeopleList';
const String loginPageRoute = '/loginPage';
const String igDetailPage = '/igDetailPage';
const String igDetailEventList = '/igDetailEventList';
const String facilitiesPage = '/facilitiesPage';
const String facilitiesDetailPage = '/facilitiesDetailPage';
const String facilitiesBookingPage = '/facilitiesBookingPage';

enum InterestGroupNames {
  R4D,
  RC4ME,
  RC4Theatre,
  CASA,
  RC4lunteers,
  ARC4NA,
  ORC4Plays,
  OrcaBakes,
  RC4Coffee,
  RC4FE,
  RC4Moda,
  RC4Tea,
  StrategicGames,
  RC4Badminton,
  RC4Basketball,
  RC4CaptainsBall,
  RC4Climbing,
  RC4Dodgeball,
  RC4Floorball,
  RC4occer,
  RC4Squash,
  RC4TableTennis,
  RC4Tchoukball,
  RC4Tennis,
  RC4TouchRugby,
  RC4UtimateFrisbee,
  RC4Volleyball
}

enum VenueNames { MPSH, TR1, TR2, TR3, TR4, CommonLounge }

extension EnumActionExtension on VenueNames {
  String get name {
    switch (this) {
      case VenueNames.MPSH:
        return 'MPSH';
      case VenueNames.TR1:
        return 'TR1';
      case VenueNames.TR2:
        return 'TR2';
      case VenueNames.TR3:
        return 'TR3';
      case VenueNames.TR4:
        return 'TR4';
      case VenueNames.CommonLounge:
        return 'CommonLounge';
    }
  }
}
