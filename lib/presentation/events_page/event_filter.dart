import 'package:flutter/material.dart';

class EventFilter extends StatelessWidget {
  const EventFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        EventFilterChip(
          data: "asd",
        ),
        EventFilterChip(
          data: "asd",
        ),
        EventFilterChip(
          data: "asd",
        )
      ],
    );
  }
}

class EventFilterChip extends StatelessWidget {
  final String data;
  const EventFilterChip({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
      child: SizedBox(
        height: 45,
        child: Chip(
          label: Text(data),
        ),
      ),
    );
  }
}
