import 'package:flutter/material.dart';

class EventDividerWidget extends StatelessWidget {
  const EventDividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 20,
      thickness: 5,
      indent: 20,
      endIndent: 20,
    );
  }
}
