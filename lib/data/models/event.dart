import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  Event(
      {required this.id,
      required this.title,
      required this.description,
      required this.timestamp,
      required this.imageUrl,
      required this.ig,
      required this.hosts,
      required this.attendees});
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String ig;
  final Timestamp timestamp;
  final List<String> hosts;
  final List<String> attendees;

  Event.fromSnapshot(DocumentSnapshot? snapshot)
      : id = snapshot!.id,
        title = snapshot.get("title"),
        description = snapshot.get("description"),
        timestamp = snapshot.get("timestamp"),
        ig = snapshot.get("ig"),
        imageUrl = snapshot.get("imageurl"),
        hosts = List.castFrom(snapshot.get('hosts') as List),
        attendees = List.castFrom(snapshot.get('attendees') as List);
}
