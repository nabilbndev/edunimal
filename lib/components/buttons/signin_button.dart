import 'package:flutter/material.dart';
import '../../theme/theme_data.dart';

class SignInButton extends StatelessWidget {
  final void Function() onPressed;
  const SignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Image.asset("assets/google_icon.png")),
              const SizedBox(
                width: 18,
              ),
              Text("Join", style: edunimalTextTheme.displayLarge),
            ],
          )),
    );
  }
}
