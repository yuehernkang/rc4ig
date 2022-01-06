import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rc4ig/blocs/auth_bloc/authentication_bloc.dart';

import '../../constants.dart';
import '../../data/repository/Authentication%20Repository/authentication_api.dart';
import '../../data/repository/Authentication%20Repository/authentication_repository.dart';
import 'account_page.dart';
import 'package:flutterfire_ui/auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print(snapshot);
          // User is not signed in
          if (!snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: CustomEmailSignInForm(),
                  // child: SignInScreen(
                  //     headerBuilder: (context, constraints, _) {
                  //       return Padding(
                  //         padding: const EdgeInsets.all(20),
                  //         child: AspectRatio(
                  //           aspectRatio: 1,
                  //           child: Image.network(
                  //               "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6yFoGJAEN6FZSC28nl-3CjfahMZ98l0lYoW-bx_eyTMyEyjTO3NuwJg3J_3_cBbLtcqg&usqp=CAU"),
                  //         ),
                  //       );
                  //     },
                  //     showAuthActionSwitch: false,
                  //     providerConfigs: const [
                  //       EmailProviderConfiguration(),
                  //     ]),
                ),
              ],
            );
          }
          return const Center(
            child: SignOutButton(),
          );
        },
      ),
    );
  }
}

class CustomEmailSignInForm extends StatefulWidget {
  CustomEmailSignInForm({Key? key}) : super(key: key);

  @override
  State<CustomEmailSignInForm> createState() => _CustomEmailSignInFormState();
}

class _CustomEmailSignInFormState extends State<CustomEmailSignInForm> {
  final emailCtrl = TextEditingController();

  final passwordCtrl = TextEditingController();
  String text = "";

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return AuthFlowBuilder<EmailFlowController>(
      builder: (context, state, controller, _) {
        if (state is AwaitingEmailAndPassword) {
          return Column(
            children: [
              Text(text),
              TextField(controller: emailCtrl),
              TextField(controller: passwordCtrl),
              ElevatedButton(
                onPressed: () {
                  controller.setEmailAndPassword(
                    emailCtrl.text,
                    passwordCtrl.text,
                  );
                },
                child: const Text('Sign in'),
              ),
            ],
          );
        } else if (state is SigningIn) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AuthFailed) {
          authBloc.add()
          setState(() {
            text = state.exception.toString();
          });
          // FlutterFireUIWidget that shows a human-readable error message.
          // return ErrorText(exception: state.exception);
        } else if (state is SignedIn) {
          print("SIGNED IN");
        }

        return CircularProgressIndicator();
      },
    );
  }
}

class OldLoginForm extends StatelessWidget {
  const OldLoginForm({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    void loginEmailPassword(String email, String password) {
      try {
        RepositoryProvider.of<AuthenticationRepository>(context)
            .logInWithEmailAndPassword(email: email, password: password);
      } on LogInWithEmailAndPasswordFailure catch (e) {
        print('fail');
        print(e);
      }
    }

    return Column(
      children: [
        Padding(
          padding: allPadding8,
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: CachedNetworkImage(
                    imageUrl:
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6yFoGJAEN6FZSC28nl-3CjfahMZ98l0lYoW-bx_eyTMyEyjTO3NuwJg3J_3_cBbLtcqg&usqp=CAU"),
              ),
              const SizedBox(
                height: 8.0,
              ),
              AccountTextField(
                title: 'Email',
                controller: emailController,
              ),
              const SizedBox(
                height: 8.0,
              ),
              AccountTextField(
                title: 'Password',
                obscure: true,
                controller: passwordController,
              ),
              AccountButtons(
                  title: 'Sign In',
                  onPressed: () => loginEmailPassword(
                      emailController.text, passwordController.text))
            ],
          ),
        )
      ],
    );
  }
}

class AccountTextField extends StatelessWidget {
  final String title;
  final bool obscure;
  final TextEditingController controller;

  const AccountTextField(
      {Key? key,
      required this.title,
      this.obscure = false,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration:
          InputDecoration(border: const OutlineInputBorder(), labelText: title),
    );
  }
}
