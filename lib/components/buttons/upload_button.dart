// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../theme/theme_data.dart';

class TakePicButton extends StatelessWidget {
  final void Function() onPressed;
  const TakePicButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary
              //internal content margin
              ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset("assets/camera_icon.png")),
              const SizedBox(
                width: 18,
              ),
              Text("Upload", style: edunimalTextTheme.titleLarge),
            ],
          )),
    );
  }
}
