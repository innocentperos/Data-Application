import 'package:flutter/material.dart';
import 'package:untitled1/screens/auth/login.dart';
import 'package:untitled1/uis/link.dart';

import '../../uis/button.dart';
import '../../uis/text_input_field.dart';
import '../theme_utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key, this.fromLogin = false}) : super(key: key);
  final bool fromLogin;
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                "Hello",
                style: WhiteText.copyWith(
                    fontSize: 24, fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Let get you ready",
                style: WhiteText,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: const TextInputField(
                  hint: "Email Address *",
                  prependIcon: Icons.email_outlined,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16).copyWith(top: 0),
                child: const TextInputField(
                  hint: "First Name *",
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16).copyWith(top: 0),
                child: const TextInputField(
                  hint: "Last Name *",
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16).copyWith(top: 0),
                child: const TextInputField(
                  hint: "Email Address *",
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16).copyWith(top: 0),
                child:  TextInputField(
                  hint: "Phone Number *",
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16).copyWith(top: 0),
                child:  TextInputField(
                  hint: "Password",
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16).copyWith(top: 0),
                child:  TextInputField(
                  hint: "Confirm Password *",
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                "By clicking on register, you have read and agreed to our ",
                style: WhiteText,
              ),
              const SizedBox(
                height: 4,
              ),
              LinkText(text: "Terms and Conditions", onPressed: (){
              //  TODO : Open terms and condition of the platform
              },),
              const SizedBox(
                height: 16,
              ),
              const CustomButton(text: "Register"),
              const SizedBox(
                height: 64,
              ),
              const Text(
                "Already have an account ?",
                style: WhiteText,
              ),
              CustomOutlinedButton(
                  text: "Login Instead",
                  onPressed: () {
                    if (widget.fromLogin){
                      Navigator.of(context).pop();
                      return;
                    }
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginScreen(fromRegister: true,)));
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
