import 'package:flutter/material.dart';

import '../../shared/read_more_widget.dart';
import 'event_title.dart';

class EventAboutWidget extends StatelessWidget {
  final String data;
  const EventAboutWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      child: Column(
        children: [
          const EventTitleWidget(
            title: 'About This Event',
          ),
          const SizedBox(height: 8.0),
          ReadMoreWidget(description: data)
        ],
      ),
    );
  }
}
