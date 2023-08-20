import 'package:edunimal/theme/theme_data.dart';
import 'package:flutter/material.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({
    super.key,
    required this.userName,
  });

  final String? userName;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Image.asset("assets/edunimal_brand.png"),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Welcome back, $userName!",
          style: edunimalTextTheme.bodyMedium,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Take photo and detect animal',
          style: edunimalTextTheme.bodyMedium,
        ),
      ],
    ));
  }
}
