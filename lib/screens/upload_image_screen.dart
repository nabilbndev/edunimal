import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:edunimal/components/upload_image/welcome_message_uploadimage.dart';
import 'package:edunimal/logic/function_upload_image.dart';
import 'package:edunimal/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:edunimal/logic/signin_provider.dart';
import 'package:provider/provider.dart';
import '../components/upload_image/search_result_tile.dart';
import '../components/upload_image/story_dialog_box.dart';

class UploadImagePage extends StatefulWidget {
  const UploadImagePage({super.key});

  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  final ImagePicker _picker = ImagePicker();
  Future<Response>? _responseFuture;

  void pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _responseFuture = uploadImage(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userName = Provider.of<SignInProvider>(context).userName;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edunimal'),
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
      body: FutureBuilder<Response>(
        future: _responseFuture,
        builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: brandColor,
                    strokeWidth: 5,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Searching for result",
                    style: edunimalTextTheme.bodyMedium,
                  )
                ],
              ),
            );
          } else if (snapshot.hasData) {
            var responseData = jsonDecode(snapshot.data!.toString());
            var animalName = responseData['google']['label'][0];
            var confidence = responseData['google']['confidence'][0];
            return Column(
              children: [
                SearchResult(label: animalName, confidence: confidence),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 5),
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StoryBoxAlertDialog(animalName: animalName);
                      },
                    );
                  },
                  child: Text(
                    'Story',
                    style: edunimalTextTheme.displayMedium,
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    color: brandColor,
                    size: 60,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Check your internet connection and try again',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return WelcomeMessage(userName: userName);
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: brandColor,
            splashColor: Colors.white,
            onPressed: () => pickImage(ImageSource.camera),
            tooltip: 'Take Photo',
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            backgroundColor: brandColor,
            splashColor: Colors.white,
            onPressed: () => pickImage(ImageSource.gallery),
            tooltip: 'Pick From Gallery',
            child: const Icon(
              Icons.photo_library,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
