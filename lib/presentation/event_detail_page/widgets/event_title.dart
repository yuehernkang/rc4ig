import 'package:flutter/material.dart';

class EventTitleWidget extends StatelessWidget {
  final String title;
  const EventTitleWidget({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }
}
