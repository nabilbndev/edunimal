import 'package:flutter/material.dart';

import '../../theme/theme_data.dart';

class SignInScreenHero extends StatelessWidget {
  const SignInScreenHero({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Image.asset("assets/edunimal_brand.png"),
        ),
        Text(
          "Edunimal",
          style: edunimalTextTheme.displayLarge,
        ),
      ],
    );
  }
}
