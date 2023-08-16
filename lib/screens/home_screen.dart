import 'package:edunimal/screens/signin_screen.dart';
import 'package:edunimal/screens/upload_image_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return const UploadImagePage();
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Something is wrong"),
              );
            } else {
              return const SignInScreen();
            }
          },
        ),
      ),
    );
    // StreamBuilder(stream: , builder:(context, snapshot) {

    // },
  }
}
