import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../shared/reusable_grid_view.dart';
import '../../constants.dart';
import '../../data/models/interest_group.dart';
import '../../data/repository/Interest Group Repository/interest_group_repository.dart';
import 'ig_item.dart';

class InterestGroupsList extends StatelessWidget {
  final InterestGroupRepository interestGroupRepository;

  const InterestGroupsList({Key? key, required this.interestGroupRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Interest Groups"),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: interestGroupRepository.getInterestGroups(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                // const TextField(),
                Expanded(
                    child: ReusableGridView(
                  widget: snapshot.data!.docs
                      .asMap()
                      .map((i, data) => MapEntry(
                            i,
                            IgItemCard(
                                ig: InterestGroup.fromSnapshot(data),
                                onTap: () {
                                  Navigator.pushNamed(context, igDetailPage,
                                      arguments:
                                          InterestGroup.fromSnapshot(data));
                                },
                                index: i),
                          ))
                      .values
                      .toList(),
                )),
              ],
            );
          }
        },
      ),
    );
  }
}
