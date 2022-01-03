import 'dart:math';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int _index = 0;
  bool isLoading = false;

  final _controller = TextEditingController();
  bool _submitted = false;
  bool _userExist = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hello"),
        ),
        body: Stepper(
          currentStep: _index,
          onStepCancel: () {
            if (_index > 0) {
              setState(() {
                _index -= 1;
              });
            }
          },
          onStepContinue: () async {
            //Email Verification Step
            if (_index == 0) {
              setState(() {
                isLoading = true;
              });
              await verifyId().then((result) {
                setState(() {
                  isLoading = false;
                });
                print(result);
                if (result) {
                  setState(() {
                    _index += 1;
                  });
                }
              });
            }
          },
          steps: <Step>[
            Step(
              title: Row(
                children: [
                  isLoading
                      ? CircularProgressIndicator()
                      : const Text('NUSID Verification')
                ],
              ),
              content: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            errorText: checkUserValue() ? "ERROR" : null,
                            border: OutlineInputBorder(),
                            labelText: 'Enter NUSNET ID',
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            const Step(
              title: Text('Step 2 title'),
              content: Text('Content for Step 2'),
            ),
          ],
        ));
  }

  checkUserValue<bool>() {
    verifyId().then((val) {
      if (val) {
        print("UserName Already Exits");
        _userExist = val;
      } else {
        print("UserName is Available");
        _userExist = val;
      }
    });
    return _userExist;
  }

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = _controller.value.text;
    String result = "";
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    verifyId().then((value) => value ? result = "yes" : result = "no");

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }

  Future<bool> verifyId() async {
    return Future.delayed(const Duration(seconds: 1),
        () => Random().nextInt(3) % 2 == 0 ? true : false);
  }
}
