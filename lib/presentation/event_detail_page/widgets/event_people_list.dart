import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rc4ig/data/models/user.dart';

class EventPeopleList extends StatelessWidget {
  final List<User> users;
  const EventPeopleList({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of people"),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                radius: 23,
                backgroundImage:
                    CachedNetworkImageProvider(users[index].imageurl),
              ),
              title: Text(users[index].name),
            );
          }),
    );
  }
}
