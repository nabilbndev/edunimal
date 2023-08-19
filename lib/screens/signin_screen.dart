import 'package:flutter/material.dart';
import 'package:edunimal/logic/signin_provider.dart';
import 'package:provider/provider.dart';

import '../components/buttons/signin_button.dart';
import '../components/sign_in/signin_screen_hero.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        const SizedBox(
          height: 40,
        ),
        const SignInScreenHero(),
        const SizedBox(
          height: 40,
        ),
        SignInButton(onPressed: () {
          {
            final provider =
                Provider.of<SignInProvider>(context, listen: false);
            provider.signInWithGoogle();
          }
        })
      ]),
    );
  }
}
