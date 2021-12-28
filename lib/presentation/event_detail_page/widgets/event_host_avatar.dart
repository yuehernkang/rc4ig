import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rc4ig/data/models/user.dart';

class EventHostAvatar extends StatelessWidget {
  final User user;
  const EventHostAvatar({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: CachedNetworkImageProvider(user.imageurl),
          ),
          Text(
            user.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
