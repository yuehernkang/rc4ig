import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rc4ig/data/models/event.dart';
import 'package:rc4ig/data/models/user.dart';
import 'package:rc4ig/data/repository/Interest%20Group%20Repository/interest_group_repository.dart';

import '../../../constants.dart';
import 'event_host_avatar.dart';
import 'event_title.dart';

class EventPeopleWidget extends StatelessWidget {
  final String title;
  final String docId;

  EventPeopleWidget({Key? key, required this.title, required this.docId})
      : super(key: key);
  final items = List<User>.generate(
      1000,
      (i) => User(
          name: i.toString(),
          email: "yuehernkang@hotmail.com",
          imageurl:
              "https://upload.wikimedia.org/wikipedia/en/d/da/Matt_LeBlanc_as_Joey_Tribbiani.jpg"));

  @override
  Widget build(BuildContext context) {
    final InterestGroupRepository interestGroupRepository =
        RepositoryProvider.of<InterestGroupRepository>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EventTitleWidget(
                title: title,
              ),
              InkWell(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, eventPeopleListRoute,
                        arguments: items);
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: FutureBuilder<DocumentSnapshot>(
              future: interestGroupRepository.getAttendees(docId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Event.fromSnapshot(snapshot.data).attendees.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder<DocumentSnapshot>(
                      future: interestGroupRepository.getUserObject(
                          Event.fromSnapshot(snapshot.data).attendees[index]),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return EventHostAvatar(
                              user: User.fromSnapshot(snapshot.data));
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
