import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../data/models/event.dart';
import '../../data/repository/Interest Group Repository/interest_group_repository.dart';
import 'event_card.dart';
import 'event_filter.dart';

class EventsList extends StatelessWidget {
  final InterestGroupRepository interestGroupRepository;

  const EventsList({Key? key, required this.interestGroupRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
            child: EventFilter(),
          ),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
                future: interestGroupRepository.getEvents(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView(
                        shrinkWrap: true,
                        children: snapshot.data!.docs
                            .asMap()
                            .map((i, data) => MapEntry(
                                i, EventCard(event: Event.fromSnapshot(data))))
                            .values
                            .toList());
                  }
                }),
          ),
        ],
      ),
    );
  }
}
