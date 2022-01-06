import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:rc4ig/blocs/auth_bloc/authentication_bloc.dart';
import 'package:rc4ig/data/models/social_post.dart';
import 'package:rc4ig/data/models/user.dart' as rc4_user;
import 'package:rc4ig/data/repository/Interest%20Group%20Repository/interest_group_repository.dart';
import 'package:rc4ig/presentation/home_page/new_post.dart';

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
    double topPadding = MediaQuery.of(context).padding.top;

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
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top),
                      child: HomePageNewPost(),
                    );
                  },
                );
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
        Post post = Post.fromSnapshot(snapshot);
        return SocialFeedPostItem(
          post: post,
        );
      },
    );
  }
}

class SocialFeedPostItem extends StatelessWidget {
  final Post post;
  const SocialFeedPostItem({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InterestGroupRepository igrepo =
        RepositoryProvider.of<InterestGroupRepository>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<DocumentSnapshot>(
          future: igrepo.getUserObject(post.postedBy),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              rc4_user.User user = rc4_user.User.fromSnapshot(snapshot.data);

              return Row(
                children: [
                  Padding(
                    padding: allPadding8,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: CachedNetworkImageProvider(
                        user.imageurl,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        DateTimeFormat.relative(post.timestamp) + " ago",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              );
            }
            return CircularProgressIndicator();
          },
        ),
        Padding(
          padding: allPadding8,
          child: Text(
            post.content,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Divider()
      ],
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
