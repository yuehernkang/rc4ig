import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String email;
  final String imageurl;

  const User({required this.name, required this.email, required this.imageurl});

  /// Empty user which represents an unauthenticated user.
  static const User empty = User(name: '', email: '', imageurl: '');

  User.fromSnapshot(DocumentSnapshot? snapshot)
      : name = snapshot!.get('name'),
        email = snapshot.get('email'),
        imageurl = snapshot.get('imageurl');
}
