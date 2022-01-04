import 'package:flutter/material.dart';

import '../../constants.dart';

class RC4HomePage extends StatelessWidget {
  const RC4HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
        ),
        body: Column(
          children: const [
            HomePageCreatePostSection(),
            HomePageFeatureSection(),
            HomePageAnnouncementSection()
          ],
        ));
  }
}

class HomePageCreatePostSection extends StatelessWidget {
  const HomePageCreatePostSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: allPadding8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                print("hello");
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Padding(
                  padding: allPadding8,
                  child: Text(
                    'Whats on your mind?',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
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
