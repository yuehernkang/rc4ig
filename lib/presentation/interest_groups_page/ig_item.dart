import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

import '../../data/models/interest_group.dart';

class IgItemCard extends StatelessWidget {
  final InterestGroup ig;
  final int index;
  final VoidCallback onTap;
  const IgItemCard(
      {Key? key, required this.ig, required this.index, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Colors.teal,
      Colors.amber,
      Colors.lightBlue,
      Colors.deepPurple
    ];
    return Card(
      elevation: 16,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.0))),
      color: colors[index % 4],
      child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 160,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0)),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: ig.imageUrl,
                    placeholder: (context, url) =>
                        const BlurHash(hash: 'L19%hp0002Ng00-9?atl00?H=x^\$'),
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Center(
                child: Text(ig.title.toString()),
              )
            ],
          )),
    );
  }
}
