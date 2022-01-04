import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants.dart';
import '../../data/models/event.dart';
import '../../data/repository/Interest%20Group%20Repository/interest_group_repository.dart';
import '../events_page/event_card.dart';
import 'package:shimmer/shimmer.dart';

class IGDetailEventList extends StatelessWidget {
  final String igName;
  const IGDetailEventList({Key? key, required this.igName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InterestGroupRepository interestGroupRepository =
        RepositoryProvider.of<InterestGroupRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: interestGroupRepository.getIGEvents(igName),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => const EventListShimmer());
          } else {
            return ListView(
                children: snapshot.data!.docs
                    .asMap()
                    .map((i, data) =>
                        MapEntry(i, EventCard(event: Event.fromSnapshot(data))))
                    .values
                    .toList());
          }
        },
      ),
    );
  }
}

class EventListShimmer extends StatelessWidget {
  const EventListShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 140,
      child: Padding(
        padding: allPadding8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                  child: SizedBox(
                    width: 200,
                    height: 24,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.white,
                      child: const Card(
                        child: Text("Hello"),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 48,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    child: const Card(
                      child: Text("Hello"),
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 24,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    child: const Card(
                      child: Text("Hello"),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 80,
              width: 120,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
                child: const Card(
                  child: Text("Hello"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
