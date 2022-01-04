import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: const [SignOutButton()],
      ),
      body: Column(
        children: [
          ProfileTitleSection(),
          MaterialButton(
            onPressed: () {},
            child: Text("Edit Profile"),
            color: Colors.teal,
          ),
          ProfileActivitySection()
        ],
      ),
    );
  }
}

class ProfileTitleSection extends StatelessWidget {
  const ProfileTitleSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: CircleAvatar(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text("Name"), Text("@Handle"), Text("FLoor")],
        )
      ],
    );
  }
}

class ProfileActivitySection extends StatelessWidget {
  const ProfileActivitySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [Text("Activity")],
      ),
    );
  }
}
