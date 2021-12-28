import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../data/repository/Interest Group Repository/interest_group_repository.dart';
import 'widgets/event_about_section.dart';
import 'widgets/event_date_widget.dart';
import 'widgets/event_divider.dart';
import 'widgets/event_people_widget.dart';
import 'widgets/event_title.dart';

//TODO : TEXT WRAPPING FOR THE NAMES BELOW CIRCLE AVATAR
//TODO : READ MORE BUTTON TO WRAP TEXT FOR ABOUT SECTION
//TODO : CHECK IF CURRENT USER IS ALREADY PART OF THIS EVENT TO CONFIGURE JOIN BUTTON
class EventDetailPage extends StatefulWidget {
  final String documentReference;
  const EventDetailPage({Key? key, required this.documentReference})
      : super(key: key);

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  final InterestGroupRepository igrepo = InterestGroupRepository();
  final DateTime fakeDate = DateTime.parse(DateTime.now().toString());

  final bool _pinned = true;
  final bool _snap = false;
  final bool _floating = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: igrepo.getEventDetails(widget.documentReference),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: _pinned,
                  snap: _snap,
                  floating: _floating,
                  expandedHeight: 300.0,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding:
                        EdgeInsetsDirectional.only(start: 16, bottom: 16),
                    title: EventTitleWidget(
                      title: asyncSnapshot.data!.get('title'),
                    ),
                    background: ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Colors.black],
                        ).createShader(Rect.fromLTRB(
                            0, 0, rect.width * 2, rect.height * 2));
                      },
                      child: CachedNetworkImage(
                        imageUrl: asyncSnapshot.data!.get('imageurl'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // EventTitleWidget(
                      //   title: asyncSnapshot.data!.get('title'),
                      // ),
                      EventAboutWidget(
                        data: asyncSnapshot.data!.get('description'),
                      ),
                      const EventDividerWidget(),
                      EventPeopleWidget(
                        title: 'Your Hosts',
                        docId: asyncSnapshot.data!.id,
                      ),
                      const EventDividerWidget(),
                      EventPeopleWidget(
                        title: 'Attendees',
                        docId: asyncSnapshot.data!.id,
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          //NOT LOGGED IN
          if (!snapshot.hasData) {
            return JoinButton(
              callback: () {
                Navigator.pushNamed(context, loginPageRoute);
              },
            );
          }
          return JoinButton(
            callback: () {
              igrepo.joinEvent(widget.documentReference,
                  FirebaseAuth.instance.currentUser!.uid);
            },
          );
        },
      ),
    );
  }
}

class JoinButton extends StatelessWidget {
  final VoidCallback callback;
  const JoinButton({Key? key, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: callback,
      label: const Text('Join'),
      icon: const Icon(Icons.person_add_alt),
      backgroundColor: Colors.teal,
    );
  }
}

class LeaveButton extends StatelessWidget {
  const LeaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        // Add your onPressed code here!
      },
      label: const Text('Leave'),
      icon: const Icon(Icons.person_add_alt),
      backgroundColor: Colors.redAccent,
    );
  }
}
