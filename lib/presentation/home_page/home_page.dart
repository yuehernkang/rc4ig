import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: const [HomePageFeatureSection(), HomePageAnnouncementSection()],
    ));
  }
}

class HomePageFeatureSection extends StatelessWidget {
  const HomePageFeatureSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HomePageAnnouncementSection extends StatelessWidget {
  const HomePageAnnouncementSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
