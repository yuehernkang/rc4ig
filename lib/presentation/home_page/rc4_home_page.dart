import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:rc4ig/data/models/social_post.dart';
import 'package:rc4ig/data/repository/Interest%20Group%20Repository/interest_group_repository.dart';

import '../../constants.dart';

class RC4HomePage extends StatelessWidget {
  const RC4HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InterestGroupRepository igrepo =
        RepositoryProvider.of<InterestGroupRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Column(
        children: const [
          HomePageCreatePostSection(),
          Expanded(child: HomePageSocialFeed()),
          // HomePageTabBar(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final InterestGroupRepository igrepo =
              RepositoryProvider.of<InterestGroupRepository>(context);

          for (int i = 0; i < 500; i++) {
            Post post = Post(
                content: "Hallo${i}",
                postedBy: FirebaseAuth.instance.currentUser!.uid,
                timestamp: Timestamp.now().toDate());

            igrepo.addNewSocialPost(post);
          }
        },
      ),
    );
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

class HomePageTabBar extends StatelessWidget {
  const HomePageTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
            ],
          ),
          Expanded(
            child: const TabBarView(
              children: [
                Icon(Icons.directions_car),
                Icon(Icons.directions_transit),
              ],
            ),
          ),
        ],
      ),
      // child: Scaffold(
      //   appBar: AppBar(
      //     bottom: ,
      //   ),
      // ),
    );
  }
}

class HomePageSocialFeed extends StatelessWidget {
  const HomePageSocialFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InterestGroupRepository igrepo =
        RepositoryProvider.of<InterestGroupRepository>(context);
    return FirestoreListView<Map<String, dynamic>>(
      pageSize: 20,
      query: igrepo.getSocialPosts(),
      itemBuilder: (context, snapshot) {
        Map<String, dynamic> user = snapshot.data();

        return Text('User name is ${user['content']}');
      },
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
