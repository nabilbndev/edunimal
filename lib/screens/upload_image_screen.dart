import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:edunimal/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:edunimal/logic/signin_provider.dart';
import 'package:provider/provider.dart';

import '../components/others/search_result_tile.dart';

class UploadImagePage extends StatefulWidget {
  const UploadImagePage({super.key});

  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  final ImagePicker _picker = ImagePicker();
  Future<Response>? _responseFuture;
  String apiKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiODU0NWFhNjItNjIxYy00NzNhLTkyNzktN2VmOWZhZjI1YjA5IiwidHlwZSI6ImFwaV90b2tlbiJ9.usMATUzTk828oKKulvS3zQHDzWChkZ_lYiA1POHcT_w";
  Future<Response> uploadImage(File imageFile) async {
    var dio = Dio();

    String url = "https://api.edenai.run/v2/image/object_detection";

    String filename = basename(imageFile.path);

    FormData formData = FormData.fromMap({
      "providers": "google",
      "file": await MultipartFile.fromFile(imageFile.path, filename: filename),
      "attributes_as_list": true,
      // Add other fields if needed
    });

    dio.options.headers["Authorization"] = "Bearer $apiKey";
    dio.options.headers["Content-Type"] =
        "multipart/form-data; boundary=${formData.boundary}";
    return await dio.post(url, data: formData);
  }

  Future<String> generateStory(String text) async {
    final dio = Dio();

    final options = Options(
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    final response = await dio.post(
      'https://api.edenai.run/v2/text/generation',
      options: options,
      queryParameters: {
        'providers': 'openai',
        'text':
            "Generate a short and interesting fairytale about $text for kids",
      },
    );

    if (response.statusCode == 200) {
      final responseString = jsonDecode(response.toString());
      return responseString['openai']['generated_text'];
    } else {
      throw Exception('Failed to generate text');
    }
  }

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
                  ),
                  const SizedBox(
                    height: 5,
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
                  onPressed: () async {
                    String story = await generateStory(animalName);
                    // ignore: use_build_context_synchronously
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          title: Text('Story of a $animalName'),
                          content: Text(story),
                          actions: [
                            TextButton(
                              child: const Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Read a story about $animalName'),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.black),
            );
          } else {
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
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Take photo and detect animal',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ));
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            splashColor: brandColor,
            onPressed: () => pickImage(ImageSource.camera),
            tooltip: 'Take Photo',
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            splashColor: brandColor,
            onPressed: () => pickImage(ImageSource.gallery),
            tooltip: 'Pick From Gallery',
            child: const Icon(Icons.photo_library),
          ),
        ],
      ),
    );
  }
}
