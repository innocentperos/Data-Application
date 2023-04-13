import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/auth/auth_services.dart';
import 'package:untitled1/screens/auth/register.dart';
import 'package:untitled1/screens/theme_utils.dart';
import 'package:untitled1/uis/button.dart';
import 'package:untitled1/uis/link.dart';
import 'package:untitled1/uis/text_input_field.dart';
import 'package:untitled1/utils.dart';

import '../home/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, this.fromRegister = false}) : super(key: key);

  final bool fromRegister;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                "Welcome",
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
                child: TextInputField(
                  hint: "Email Address",
                  controller: emailController,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16).copyWith(top: 0),
                child: TextInputField(
                  hint: "Password",
                  controller: passwordController,
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
                  loginUser(context);
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

  void loginUser(BuildContext context) async {
    if (emailController.value.text.isEmpty) {
      showSnackBar(context, "Please provide your registered email address");
      return;
    }
    if (passwordController.value.text.isEmpty) {
      showSnackBar(context, "Please provide your account password");
      return;
    }

    try {
      UserCredential? userCredential = await AuthService.signIn(
          emailController.value.text, passwordController.value.text);

      if (userCredential != null && userCredential?.user != null) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Home()));
      }

    } on FirebaseAuthException catch (err) {
      if (kDebugMode) {
        print("failed to sign in user -------------------------");
        print(err);
      }

      //  Logging in failed check the conditions and handle

      switch (err.code) {
        case "invalid-email":
          showSnackBar(context, "Provide a valid email address");
          break;
        case "user-not-found":
          showSnackBar(
              context, "No account found with the provided email address");
          break;
        case "wrong-password":
          showSnackBar(context, "Wrong password provided");
          break;
        default:
          showSnackBar(context, "Something went wrong, try again later");
          break;
      }
    }
  }
}
