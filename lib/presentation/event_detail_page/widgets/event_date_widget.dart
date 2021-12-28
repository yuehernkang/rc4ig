import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//TODO : FIX ADD TO DEVICE CALENDAR
class EventDateWidget extends StatelessWidget {
  const EventDateWidget({
    Key? key,
    required this.fakeDate,
  }) : super(key: key);

  final DateTime fakeDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final Event event = Event(
          title: 'Event title',
          description: 'Event description',
          location: 'Event location',
          startDate: fakeDate,
          endDate: fakeDate,
        );
        Add2Calendar.addEvent2Cal(event);
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 16.0, 16.0, 16.0),
                child: Icon(Icons.calendar_today),
              ),
              Column(
                children: [
                  Text(DateFormat('EEEE, d MMMM y').format(fakeDate)),
                  Row(
                    children: [
                      Text(DateFormat('jm').format(fakeDate)),
                      const Text(' - '),
                      Text(DateFormat('jm').format(fakeDate)),
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
