import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ReadMoreWidget extends StatelessWidget {
  final String description;

  const ReadMoreWidget({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(description,
        style: const TextStyle(color: Colors.black, fontSize: 16),
        trimLines: 4,
        colorClickableText: Colors.teal,
        trimMode: TrimMode.Line,
        trimCollapsedText: ' ...more',
        trimExpandedText: ' less',
        delimiter: '');
  }
}
