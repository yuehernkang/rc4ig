import 'package:cloud_firestore/cloud_firestore.dart';

class InterestGroup {
  InterestGroup(
      {required this.title,
      required this.category,
      required this.imageUrl,
      required this.description});
  final String title;
  final String category;
  final String imageUrl;
  final String description;

  InterestGroup.fromSnapshot(DocumentSnapshot snapshot)
      : title = snapshot.get("title"),
        category = snapshot.get("category"),
        imageUrl = snapshot.get("imageurl"),
        description = snapshot.get("description");
}
