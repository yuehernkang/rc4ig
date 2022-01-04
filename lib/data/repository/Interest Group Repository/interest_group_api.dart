import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rc4ig/data/models/social_post.dart';

import '../../../constants.dart';
import '../../models/venue.dart';

class RC4IGAPI {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getInterestGroups() {
    return firestore.collection('interest_groups').get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getEvents() {
    return firestore
        .collection('events')
        .where('timestamp', isGreaterThan: Timestamp.now())
        .orderBy('timestamp')
        .get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getEventDetails(String docId) {
    return firestore.collection('events').doc(docId).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getIGEvents(String names) {
    return firestore.collection('events').where('ig', isEqualTo: names).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getFacilitySchedule(Venue names) {
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

  Stream<DocumentSnapshot<Map<String, dynamic>>> getAttendeesStream(
      String docId) {
    return firestore.collection('events').doc(docId).snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserObject(String uid) {
    return firestore.collection('users').doc(uid).get();
  }

//-----------------------EVENT PAGE-----------------------
  Future<void> joinEvent(String eventDocId, String? uid) {
    return firestore.collection('events').doc(eventDocId).update({
      'attendees': FieldValue.arrayUnion([uid])
    });
  }

  Future<void> leaveEvent(String eventDocId, String? uid) {
    return firestore.collection('events').doc(eventDocId).update({
      'attendees': FieldValue.arrayRemove([uid])
    });
  }

  //-----------------------HOME PAGE (SOCIAL) -----------------------
  Query<Map<String, dynamic>> getSocialPosts() {
    return firestore.collection('social').orderBy('timestamp');
  }

  Future<DocumentReference<Map<String, dynamic>>> addNewSocialPost(Post post) {
    return firestore.collection('social').add(post.toJson());
  }
}
