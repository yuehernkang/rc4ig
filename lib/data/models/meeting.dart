import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

import 'venue.dart';

class Meeting {
  Meeting(
      {required this.eventName,
      required this.from,
      required this.to,
      required this.background,
      required this.venue});

  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color background;
  final String venue;

  Meeting.fromSnapshot(DocumentSnapshot snapshot)
      : eventName = snapshot.get('eventName'),
        from = snapshot.get('from').toDate(),
        to = snapshot.get('to').toDate(),
        background = Color(snapshot.get('background')),
        venue = snapshot.get('venue');
}
