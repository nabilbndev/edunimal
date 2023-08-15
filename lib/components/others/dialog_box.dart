import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final VoidCallback onPressedCamera;
  final VoidCallback onPressedGallery;

  const DialogBox(
      {Key? key, required this.onPressedCamera, required this.onPressedGallery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
// This line will make the dialog appear at the bottom of the page
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        height: 200,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose an option',
              style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.inverseSurface),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: onPressedCamera,
                  child: const Column(
                    children: [Icon(Icons.camera), Text("Camera")],
                  ),
                ),
                ElevatedButton(
                  onPressed: onPressedGallery,
                  child: const Column(
                    children: [Icon(Icons.image), Text("Gallery")],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
