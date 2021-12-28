import 'package:flutter/material.dart';

class ReusableGridView extends StatelessWidget {
  final List<Widget> widget;
  const ReusableGridView({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
        scrollDirection: Axis.vertical,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: widget);
  }
}
