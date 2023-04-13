import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/screens/home/edit_profile.dart';
import 'package:untitled1/screens/theme_utils.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemedDarkBg,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: const [
      //       Text("Innocent Peros"),
      //       Text("Profile", style: TextStyle(fontSize: 12),),
      //     ],
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: Builder(
        builder: (context) => SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 64,
                    backgroundColor: ThemedColorDark,
                    backgroundImage: NetworkImage(
                        "https://github.com/innocentperos/album-vite"
                        "/blob/origin/public/images/avatar3.jpg?raw=true"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Innocent Peros",
                    style: WhiteText.copyWith(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "innocentperos@yahoo.com",
                    style: WhiteText.copyWith(fontSize: 18, color: ThemedColor),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  buildIListItem(
                      icon: Icons.edit,
                      label: "Edit Profile",
                      onClicked: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const EditProfileScreen()));
                      }),
                  const SizedBox(
                    height: 8,
                  ),
                  buildIListItem(
                      icon: Icons.logout,
                      label: "Logout",
                      onClicked: () async {
                        try {
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const InitialPage()));
                        } catch (error) {
                          if (kDebugMode) print(error);
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InkWell buildIListItem(
      {required IconData icon,
      required String label,
      required Function() onClicked}) {
    return InkWell(
      onTap: () {
        onClicked();
      },
      borderRadius: BorderRadius.circular(16),
      splashColor: ThemedColorDark.withOpacity(0.5),
      highlightColor: ThemedColorDark.withOpacity(0.1),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              label,
              style: WhiteText.copyWith(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
