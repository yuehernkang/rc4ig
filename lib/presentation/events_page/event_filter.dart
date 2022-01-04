import 'package:flutter/material.dart';

class EventFilter extends StatelessWidget {
  const EventFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        EventFilterButton(),
        EventFilterChip(
          data: "asd",
        ),
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

class EventFilterButton extends StatelessWidget {
  const EventFilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 8.0, 0),
      child: SizedBox(
        height: 45,
        child: ActionChip(
          label: Icon(Icons.tune),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return const EventFilterSheet();
                });
          },
        ),
      ),
    );
  }
}

class EventFilterSheet extends StatelessWidget {
  const EventFilterSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: () {}, child: Text("Cancel")),
                Text("Filters"),
                TextButton(onPressed: () {}, child: Text("Reset")),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    color: const Color(0xffeeee00),
                    height: 300.0,
                    alignment: Alignment.center,
                    child: const Text('Fixed Height Content'),
                  ),
                  Container(
                    color: const Color(0xff008000),
                    height: 250.0,
                    alignment: Alignment.center,
                    child: const Text('Fixed Height Content'),
                  ),
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {},
            child: Text("hellasdsado"),
          )
        ],
      ),
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
        child: ActionChip(
          label: Row(
            children: [Text(data), Icon(Icons.expand_more)],
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
