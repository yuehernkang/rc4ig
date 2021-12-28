import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../constants.dart';
import '../../models/venue.dart';

class RC4IGAPI {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getInterestGroups() {
    return firestore.collection('interest_groups').get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getEvents() {
    return firestore.collection('events').orderBy('timestamp').get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getEventDetails(String docId) {
    return firestore.collection('events').doc(docId).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getIGEvents(String names) {
    return firestore.collection('events').where('ig', isEqualTo: names).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getFacilitySchedule(Venue names) {
    print(names.toString().split('.').last);
    return firestore
        .collection('facilities_booking')
        .where('venue', isEqualTo: names.venueName.name)
        .get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getHosts(String docId) {
    return firestore.collection('events').doc(docId).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getAttendees(String docId) {
    return firestore.collection('events').doc(docId).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserObject(String uid) {
    return firestore.collection('users').doc(uid).get();
  }

  Future<void> joinEvent(String eventDocId, String uid) {
    return firestore.collection('events').doc(eventDocId).update({
      'attendees': FieldValue.arrayUnion([uid])
    });
  }
}
