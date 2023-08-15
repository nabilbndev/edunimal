import 'dart:io';

import 'package:edunimal/components/buttons/upload_button.dart';
import 'package:edunimal/theme/theme_data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/others/dialog_box.dart';
import '../provider/signin_provider.dart';

class TakePicScreen extends StatefulWidget {
  const TakePicScreen({super.key});

  @override
  State<TakePicScreen> createState() => _TakePicScreenState();
}

class _TakePicScreenState extends State<TakePicScreen> {
  File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    final userName = Provider.of<SignInProvider>(context).userName;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          "Edunimal",
          style: edunimalTextTheme.titleLarge,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                final provider =
                    Provider.of<SignInProvider>(context, listen: false);
                provider.googleLogOut();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      body: Container(
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.onBackground),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Welcome back! $userName",
                  style: edunimalTextTheme.bodyMedium,
                ),
                _selectedImage != null
                    ? Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(
                                _selectedImage!,
                              ),
                            )),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Image.asset("assets/edunimal_brand.png"),
                      ),
                TakePicButton(onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogBox(onPressedCamera: () {
                          _pickImageFromCamera();
                        }, onPressedGallery: () {
                          _pickImageFromGallery();
                        });
                      });
                })
              ]),
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (returnedImage == null) return;
      _selectedImage = File(returnedImage.path);
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (returnedImage == null) return;
      _selectedImage = File(returnedImage.path);
    });
  }
}
