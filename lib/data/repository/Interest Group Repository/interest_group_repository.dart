import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rc4ig/data/models/social_post.dart';
import '../../../constants.dart';
import '../../models/venue.dart';
import 'interest_group_api.dart';

class InterestGroupRepository {
  RC4IGAPI interestGroupAPI = RC4IGAPI();

  Future<QuerySnapshot<Map<String, dynamic>>> getInterestGroups() {
    return interestGroupAPI.getInterestGroups();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getEvents() {
    return interestGroupAPI.getEvents();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getEventDetails(String docId) {
    return interestGroupAPI.getEventDetails(docId);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getIGEvents(String igName) {
    return interestGroupAPI.getIGEvents(igName);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getFacilitySchedule(
      Venue venueName) {
    return interestGroupAPI.getFacilitySchedule(venueName);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getHosts(String docId) {
    return interestGroupAPI.getHosts(docId);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getAttendees(String docId) {
    return interestGroupAPI.getAttendees(docId);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getAttendeesStream(
      String docId) {
    return interestGroupAPI.getAttendeesStream(docId);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserObject(String uid) {
    return interestGroupAPI.getUserObject(uid);
  }

  Future<void> joinEvent(String eventDocId, String? uid) {
    return interestGroupAPI.joinEvent(eventDocId, uid);
  }

  Future<void> leaveEvent(String eventDocId, String? uid) {
    return interestGroupAPI.leaveEvent(eventDocId, uid);
  }

  //-----------------------HOME PAGE (SOCIAL) -----------------------
  Query<Map<String, dynamic>> getSocialPosts() {
    return interestGroupAPI.getSocialPosts();
  }

  Future<DocumentReference<Map<String, dynamic>>> addNewSocialPost(Post post) {
    return interestGroupAPI.addNewSocialPost(post);
  }
}
