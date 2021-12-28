import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/Interest%20Group%20Repository/interest_group_repository.dart';

import 'events_list.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EventsList(
        interestGroupRepository:
            RepositoryProvider.of<InterestGroupRepository>(context));
  }
}
