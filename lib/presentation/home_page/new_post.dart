import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rc4ig/blocs/auth_bloc/authentication_bloc.dart';
import 'package:rc4ig/constants.dart';

class HomePageNewPost extends StatelessWidget {
  const HomePageNewPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Padding(
          padding: allPadding8,
          child: HomePageNewPostHeader(),
        ),
        Divider(
          thickness: 4,
        ),
        Padding(
          padding: allPadding8,
          child: HomePageNewPostUser(),
        ),
        Expanded(
          child: Padding(
            padding: allPadding8,
            child: HomePageNewPostTextField(),
          ),
        ),
      ],
    );
  }
}

class HomePageNewPostHeader extends StatelessWidget {
  const HomePageNewPostHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            iconSize: 24,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
        Text("Create Post"),
        MaterialButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {},
          child: Text("Post"),
        )
      ],
    );
  }
}

class HomePageNewPostUser extends StatelessWidget {
  const HomePageNewPostUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(),
        SizedBox(
          width: 8,
        ),
        Column(
          children: [Text("Name")],
        )
      ],
    );
  }
}

class HomePageNewPostTextField extends StatelessWidget {
  const HomePageNewPostTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)), // your color
      ),
      autofocus: true,
      keyboardType: TextInputType.multiline,
      maxLength: null,
      maxLines: null,
      expands: true,
    );
  }
}
