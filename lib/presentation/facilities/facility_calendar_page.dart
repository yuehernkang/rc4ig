import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../data/data_sources/meeting_data_source.dart';
import '../../data/models/meeting.dart';
import '../../data/models/venue.dart';
import '../../data/repository/Interest%20Group%20Repository/interest_group_repository.dart';

class FacilitiesDetailPage extends StatefulWidget {
  final Venue venue;

  const FacilitiesDetailPage({Key? key, required this.venue}) : super(key: key);

  @override
  State<FacilitiesDetailPage> createState() => _FacilitiesDetailPageState();
}

class _FacilitiesDetailPageState extends State<FacilitiesDetailPage> {
  @override
  Widget build(BuildContext context) {
    var _calendarController = CalendarController();
    final _formKey = GlobalKey<FormBuilderState>();

    @override
    void dispose() {
      super.dispose();
      _calendarController.dispose();
    }

    void _onChanged(DateTime? datetime) {
      print("hello");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.venue.displayName),
      ),
      body: Center(
        child: FutureBuilder<QuerySnapshot>(
          future: RepositoryProvider.of<InterestGroupRepository>(context)
              .getFacilitySchedule(widget.venue),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              List<Meeting> appointments = <Meeting>[];
              appointments = snapshot.data!.docs
                  .map((data) => Meeting.fromSnapshot(data))
                  .toList();

              return SfCalendar(
                view: CalendarView.week,
                dataSource: MeetingDataSource(appointments),
                firstDayOfWeek: 1,
                showDatePickerButton: true,
                showNavigationArrow: true,
                controller: _calendarController,
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var selectedDate = _calendarController.selectedDate;
          selectedDate ??= DateTime.now();
          if (selectedDate.isBefore(DateTime.now())) {
            selectedDate = DateTime.now();
          }
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                height: MediaQuery.of(context).size.height * 0.90,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: const Text(
                              "Cancel",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.teal),
                            ),
                            onTap: () => Navigator.pop(context),
                          ),
                          const Text(
                            "New Event",
                            style: TextStyle(fontSize: 20),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.saveAndValidate() ??
                                  false) {
                                if (true) {
                                  // Either invalidate using Form Key
                                  _formKey.currentState?.invalidateField(
                                      name: 'eventName',
                                      errorText: 'Email already taken.');
                                  // OR invalidate using Field Key
                                  // _emailFieldKey.currentState?.invalidate('Email already taken.');
                                }

                                print('Valid');
                              } else {
                                print('Invalid');
                              }
                              print(_formKey.currentState?.validate());
                            },
                            child: const Text("Add"),
                          )
                          // InkWell(
                          //   child: const Text(
                          //     "Add",
                          //     style: TextStyle(fontSize: 20, color: Colors.teal),
                          //   ),

                          //   onTap: () {},
                          // ),
                        ],
                      ),
                      FormBuilder(
                        key: widget.key,
                        child: Column(
                          children: [
                            FormBuilderTextField(
                              name: 'eventName',
                              decoration: const InputDecoration(
                                labelText: 'Event Name',
                              ),
                              // valueTransformer: (text) => num.tryParse(text),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: FormBuilderDateTimePicker(
                                    name: 'date_range',
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2030),
                                    inputType: InputType.date,
                                    format: DateFormat('EEEE, MMMM d'),
                                    initialValue: selectedDate,
                                    decoration: const InputDecoration(
                                      labelText: 'Start Date',
                                      // helperText: 'Helper text',
                                    ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                    ]),
                                  ),
                                ),
                                Expanded(
                                  child: FormBuilderDateTimePicker(
                                    name: 'date',
                                    // onChanged: _onChanged,
                                    inputType: InputType.time,
                                    decoration: const InputDecoration(
                                      labelText: 'Start Time',
                                    ),
                                    format: DateFormat('jm'),
                                    initialValue: DateTime(
                                            selectedDate!.year,
                                            selectedDate.month,
                                            selectedDate.day,
                                            selectedDate.hour,
                                            0)
                                        .add(const Duration(hours: 1)),
                                    // enabled: true,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: FormBuilderDateTimePicker(
                                    name: 'date_range',
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2030),
                                    inputType: InputType.date,
                                    format: DateFormat('EEEE, MMMM d'),
                                    initialValue: selectedDate,
                                    decoration: const InputDecoration(
                                      labelText: 'End Date',
                                      // helperText: 'Helper text',
                                    ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                    ]),
                                  ),
                                ),
                                Expanded(
                                  child: FormBuilderDateTimePicker(
                                    name: 'date',
                                    onChanged: (d) => _onChanged(d),
                                    inputType: InputType.time,
                                    decoration: const InputDecoration(
                                      labelText: 'End Time',
                                    ),
                                    format: DateFormat('jm'),
                                    initialValue: DateTime(
                                            selectedDate.year,
                                            selectedDate.month,
                                            selectedDate.day,
                                            selectedDate.hour,
                                            0)
                                        .add(const Duration(hours: 2)),
                                    // enabled: true,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
          // Navigator.pushNamed(context, facilitiesBookingPage,
          //     arguments: selectedDate);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
