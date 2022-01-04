import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rc4ig/presentation/home_page/home_page.dart';
import 'package:rc4ig/theme.dart';

import 'blocs/auth_bloc/authentication_bloc.dart';
import 'constants.dart';
import 'data/models/interest_group.dart';
import 'data/repository/Authentication%20Repository/authentication_api.dart';
import 'data/repository/Authentication%20Repository/authentication_repository.dart';
import 'data/repository/Interest Group Repository/interest_group_repository.dart';
import 'presentation/account/account_page.dart';
import 'presentation/events_page/events_page.dart';
import 'presentation/facilities/facilities_page.dart';
import 'presentation/interest_groups_page/ig_list.dart';
import 'rc4router.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Get any initial links
  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<InterestGroupRepository>(
          create: (context) => InterestGroupRepository()),
      RepositoryProvider<AuthenticationRepository>(
          create: (context) => AuthenticationRepository(AuthenticationAPI()))
    ],
    child: MultiBlocProvider(providers: [
      BlocProvider(create: (BuildContext context) => AuthenticationBloc())
    ], child: MyApp(initialLink: initialLink)),
  ));
}

class MyApp extends StatefulWidget {
  final PendingDynamicLinkData? initialLink;
  const MyApp({Key? key, this.initialLink}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }

  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      print(dynamicLinkData.link.path);
      // Navigator.pushNamed(context, dynamicLinkData.link.path);
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialLink != null) {
      final Uri deepLink = widget.initialLink!.link;
      print(deepLink);
      // Example of using the dynamic link to push the user to a different screen
      Navigator.pushNamed(context, eventDetailRoute,
          arguments: "H80gIv8p425bAfk2HacL");
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: RC4Theme.lightTheme,
      onGenerateRoute: RC4IGRouter.generateRoute,
      initialRoute: homeRoute,
    );
  }
}

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; //New

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      const RC4HomePage(),
      // InterestGroupsList(
      //     interestGroupRepository:
      //         RepositoryProvider.of<InterestGroupRepository>(context)),
      const EventsPage(),
      const FacilitiesPage(),
      const AccountPage(),
    ];

    return Scaffold(
        body: Center(
          child: _pages.elementAt(_selectedIndex), //New
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Interest Groups'),
            BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
            BottomNavigationBarItem(
                icon: Icon(Icons.sports_basketball_rounded),
                label: 'Facilities'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          ],
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped, //New
        ));
  }
}
