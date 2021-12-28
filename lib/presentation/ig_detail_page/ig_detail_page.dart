import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants.dart';
import '../../data/models/event.dart';
import '../../data/models/interest_group.dart';
import '../../data/repository/Interest%20Group%20Repository/interest_group_repository.dart';
import '../events_page/event_card.dart';
import '../shared/read_more_widget.dart';

class InterestGroupDetail extends StatelessWidget {
  final InterestGroup ig;

  const InterestGroupDetail({Key? key, required this.ig}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ig.title.toString()),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
              height: 250,
              child: CachedNetworkImage(
                imageUrl: ig.imageUrl,
                fit: BoxFit.cover,
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 8.0),
            child: IGDetailTitle(title: ig.title.toString()),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            child: ReadMoreWidget(description: ig.description),
          ),
          IgDetailEventsSection(
            interestGroupName: ig.title,
          )
        ],
      )),
    );
  }
}

class IgDetailEventsSection extends StatelessWidget {
  final String interestGroupName;

  const IgDetailEventsSection({Key? key, required this.interestGroupName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const IGDetailTitle(title: "Upcoming Events"),
              MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, igDetailEventList,
                        arguments: interestGroupName);
                  },
                  child: const Text(
                    "See More",
                    style: TextStyle(color: Colors.teal),
                  )),
            ],
          ),
        ),
        FutureBuilder<QuerySnapshot>(
            future: RepositoryProvider.of<InterestGroupRepository>(context)
                .getIGEvents(interestGroupName),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return SizedBox(
                  height: 400,
                  child: ListView(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade200,
                        highlightColor: Colors.white,
                        child: const Card(
                          child: Text("Hello"),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return SizedBox(
                  height: 400,
                  child: ListView(
                      children: snapshot.data!.docs
                          .asMap()
                          .map((i, data) => MapEntry(
                              i, EventCard(event: Event.fromSnapshot(data))))
                          .values
                          .toList()),
                );
              }
            })
      ],
    );
  }
}

class IGDetailTitle extends StatelessWidget {
  final String title;

  const IGDetailTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
