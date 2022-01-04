import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutterfire_ui/auth.dart';

import '../../constants.dart';
import 'profile_page/profile_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Stack(
              children: [
                IgnorePointer(
                  child: ImageSlideshow(
                      autoPlayInterval: 5000,
                      isLoop: true,
                      indicatorColor: Colors.transparent,
                      indicatorBackgroundColor: Colors.transparent,
                      height: MediaQuery.of(context).size.height,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("assets/IMG_6840.jpg"),
                            fit: BoxFit.cover,
                          )),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("assets/Frisbee_Web.jpg"),
                            fit: BoxFit.cover,
                          )),
                        ),
                      ]),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: allPadding8,
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: AccountButtons(
                              title: "Login",
                              onPressed: () =>
                                  Navigator.pushNamed(context, loginPageRoute),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: AccountButtons(
                              title: "Sign Up",
                              onPressed: () =>
                                  Navigator.pushNamed(context, signUpPageRoute),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          return const Center(
            child: ProfilePage(),
          );
        },
      ),
    );
  }
}

class AccountButtons extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const AccountButtons({Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: Colors.teal,
      child: Text(title),
      onPressed: onPressed,
    );
  }
}
