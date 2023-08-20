import 'package:dio/dio.dart';
import 'package:edunimal/logic/function_gen_story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../theme/theme_data.dart';

class StoryBoxAlertDialog extends StatelessWidget {
  StoryBoxAlertDialog({
    super.key,
    required this.animalName,
  });

  final String animalName;
  final FlutterTts flutterTts = FlutterTts();

  Future<void> textToSpeech(String story) async {
    var dio = Dio();
    var response = await dio.post(
      'https://api.edenai.run/v2/audio/text_to_speech',
      options: Options(
        headers: {
          'authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiODU0NWFhNjItNjIxYy00NzNhLTkyNzktN2VmOWZhZjI1YjA5IiwidHlwZSI6ImFwaV90b2tlbiJ9.usMATUzTk828oKKulvS3zQHDzWChkZ_lYiA1POHcT_w',
        },
      ),
      data: {
        'providers': 'amazon',
        'language': 'en',
        "rate": 20,
        "pitch": 90,
        'text': story,
        'option': 'FEMALE',
      },
    );

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      await flutterTts.speak(story);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text('Story of a $animalName', textAlign: TextAlign.center),
      content: FutureBuilder<String>(
        future: generateStory(animalName),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator(
              color: brandColor,
            );
          } else {
            if (snapshot.hasError) {
              return const Center(child: Text('Try Again'));
            } else {
              return Column(
                children: [
                  Text('${snapshot.data}'),
                  IconButton(
                    icon: const Icon(Icons.volume_up),
                    onPressed: () => textToSpeech(snapshot.data!),
                  ),
                ],
              );
            }
          }
        },
      ),
      actions: [
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
