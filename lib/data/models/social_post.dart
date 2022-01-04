import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String content;
  final String postedBy;
  final DateTime timestamp;

  Post(
      {required this.content, required this.postedBy, required this.timestamp});

  Post.fromSnapshot(DocumentSnapshot snapshot)
      : content = snapshot.get("content"),
        postedBy = snapshot.get("postedBy"),
        timestamp = snapshot.get("timestamp").toDate();

  Map<String, dynamic> toJson() => {
        'content': content,
        'postedBy': postedBy,
        'timestamp': timestamp,
      };
}
