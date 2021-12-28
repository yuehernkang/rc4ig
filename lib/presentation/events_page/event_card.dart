import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
import '../../data/models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, eventDetailRoute, arguments: event.id);
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                      child: Text(
                        DateFormat.yMMMd()
                            .add_jm()
                            .format(event.timestamp.toDate()),
                        style: const TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.w700,
                            fontSize: 12),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                            child: Text(
                              event.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ),
                          Text(
                            event.ig,
                            style: const TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
                child: SizedBox(
                  height: 80,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl: event.imageUrl,
                      placeholder: (context, url) =>
                          const BlurHash(hash: 'L19%hp0002Ng00-9?atl00?H=x^\$'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.grey,
            indent: 0,
            endIndent: 0,
            height: 8,
          )
        ],
      ),
    );
  }
}
