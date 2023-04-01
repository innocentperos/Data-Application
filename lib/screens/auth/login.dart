import 'package:flutter/material.dart';
import 'package:untitled1/screens/auth/register.dart';
import 'package:untitled1/screens/theme_utils.dart';
import 'package:untitled1/uis/button.dart';
import 'package:untitled1/uis/link.dart';
import 'package:untitled1/uis/text_input_field.dart';

import '../home/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, this.fromRegister = false}) : super(key: key);

  final bool fromRegister;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemedDarkBg,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 160,
              ),
              Text(
                "Welcome  😊",
                style: WhiteText.copyWith(
                    fontSize: 24, fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Let get you logged in",
                style: WhiteText,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: const TextInputField(
                  hint: "Email Address",
                  prependIcon: Icons.email_outlined,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16).copyWith(top: 0),
                child: const TextInputField(
                  hint: "Password",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Can`t remember your password ?",
                    style: WhiteText,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  LinkText(
                    text: "Reset it",
                    onPressed: () {},
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              CustomButton(
                text: "Login",
                loading: false,
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Home()));
                },
              ),
              const SizedBox(
                height: 64,
              ),
              const Text(
                "Don`t have an account ?",
                style: WhiteText,
              ),
              CustomOutlinedButton(
                  text: "Register",
                  loading: false,
                  onPressed: () {
                    if (widget.fromRegister) {
                      Navigator.of(context).pop();
                      return;
                    }
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegisterScreen(
                              fromLogin: true,
                            )));
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
