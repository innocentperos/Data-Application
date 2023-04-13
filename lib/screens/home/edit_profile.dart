import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/auth/auth_services.dart';
import 'package:untitled1/screens/auth/login.dart';
import 'package:untitled1/screens/theme_utils.dart';
import 'package:untitled1/uis/button.dart';
import 'package:untitled1/uis/text_input_field.dart';
import 'package:untitled1/utils.dart';

import '../../auth/profile_model.dart';
import '../../auth/user_model.dart';
import 'home.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key, this.settingProfile = false})
      : super(key: key);

  final bool settingProfile;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, user) {

        if ( user.data == null ){
          return const LoginScreen();
        }
        return WillPopScope(
          onWillPop: () async {
            if (!widget.settingProfile) {
              return true;
            }

            showDialog(
                barrierDismissible: false,
                barrierColor: Colors.black.withOpacity(0.7),
                context: context,
                builder: (context) => exitConfirmationDialog(context));

            return false;
          },
          child: Scaffold(
            backgroundColor: ThemedDarkBg,
            appBar: buildAppBar(),
            body: Builder(
              builder: (context) {
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 64,
                            backgroundColor: ThemedColorDark,
                            // backgroundImage: NetworkImage(
                            //     "https://github.com/innocentperos/album-vite"
                            //     "/blob/origin/public/images/avatar1.jpg?raw=true"),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "First Name",
                          style: WhiteText.copyWith(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        TextInputField(
                          hint: "First Name",
                          controller: firstNameController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Last Name",
                          style: WhiteText.copyWith(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        TextInputField(
                          hint: "Last Name",
                          controller: lastNameController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Phone Number",
                          style: WhiteText.copyWith(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        TextInputField(
                          hint: "Phone Number",
                          controller: phoneNumberController,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        CustomButton(
                          text: widget.settingProfile ? "Setup Profile" : "Save Profile",
                          onPressed: () async {
                            // The user is setting up his/her profile for the first time

                            if (firstNameController.value.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("Please provide your first name")));
                              return;
                            }
                            if (lastNameController.value.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("Please provide your last name")));
                              return;
                            }

                            Profile userProfile = Profile(
                                firstName: firstNameController.value.text,
                                lastName: lastNameController.value.text,
                                emailAddress:user.data!.email!,
                                balance: 0);

                            try {
                              bool? response = await Profile.insert(userProfile);

                              if (response == null) {
                                showSnackBar(
                                    context, "Something went wrong try again later");
                              } else {
                                //  The profile was created succesfully, redirect the user to the home page if response == true
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => const Home()));

                                //  Creation failed, as there exist a profile with thesame email address if response == false
                                //  This error will be rare to occur but just incase,
                              }
                            } catch (err) {
                              //An error occured while trying to insert a new profile
                              showSnackBar(
                                  context, "Something went wrong try again later");
                              if (kDebugMode) {
                                print(
                                    "Failed to create the users profile ---------------------------");
                                print(err);
                              }
                            }
                          },
                        )
                      ],
                    ),
                  ),
                );
              }
            ),
          ),
        );
      }
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text("Edit Profile"),
      automaticallyImplyLeading: !widget.settingProfile,
      centerTitle: true,
    );
  }

  AlertDialog exitConfirmationDialog(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Profile Incomplete",
        style: WhiteText,
      ),
      content: Text(
        "You have to complete your profile setup before you can use this application",
        style: WhiteText.copyWith(fontSize: 14),
      ),
      backgroundColor: ThemedDarkBg,
      actions: [
        TextButton(
          child: const Text(
            "Continue",
            style: TextStyle(color: ThemedColor),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(
            "Logout",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
