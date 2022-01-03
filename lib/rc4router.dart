import 'package:flutter/material.dart';
import 'package:rc4ig/presentation/account/sign_up_page.dart';

import 'constants.dart';
import 'data/models/interest_group.dart';
import 'data/models/user.dart';
import 'data/models/venue.dart';
import 'main.dart';
import 'presentation/account/login_page.dart';
import 'presentation/event_detail_page/event_detail_page.dart';
import 'presentation/event_detail_page/widgets/event_people_list.dart';
import 'presentation/facilities/facility_calendar_page.dart';
import 'presentation/facilities/facilities_page.dart';
import 'presentation/ig_detail_page/ig_detail_event_list.dart';
import 'presentation/ig_detail_page/ig_detail_page.dart';

class RC4IGRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
            builder: (_) => const HomePage(title: 'RC4 Interest Groups'));
      case eventDetailRoute:
        var data = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => EventDetailPage(documentReference: data));
      case eventPeopleListRoute:
        var users = settings.arguments as List<User>;
        return MaterialPageRoute(builder: (_) => EventPeopleList(users: users));
      case loginPageRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case signUpPageRoute:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case igDetailPage:
        var ig = settings.arguments as InterestGroup;
        return MaterialPageRoute(
            builder: (_) => InterestGroupDetail(
                  ig: ig,
                ));
      case igDetailEventList:
        var ig = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => IGDetailEventList(igName: ig));
      case facilitiesPage:
        return MaterialPageRoute(builder: (_) => const FacilitiesPage());
      case facilitiesDetailPage:
        Venue name = settings.arguments as Venue;
        return MaterialPageRoute(
            builder: (_) => FacilitiesDetailPage(
                  venue: name,
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
