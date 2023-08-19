import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';

Future<String> generateStory(String text) async {
  final dio = Dio();
  var rng = Random();

  String apiKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiODU0NWFhNjItNjIxYy00NzNhLTkyNzktN2VmOWZhZjI1YjA5IiwidHlwZSI6ImFwaV90b2tlbiJ9.usMATUzTk828oKKulvS3zQHDzWChkZ_lYiA1POHcT_w";
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
          "Generate a super short but super interesting fairytale about $text for young kids",
      'temperature': rng.nextDouble(),
    },
  );

  // if (response.statusCode == 200) {
  //   final responseString = jsonDecode(response.toString());
  //   return responseString['openai']['generated_text'];
  // } else {
  //   throw Exception('Failed to generate text');
  // }

  try {
    if (response.statusCode == 200) {
      final responseString = jsonDecode(response.toString());
      return responseString['openai']['generated_text'];
    } else {
      throw Exception('Failed to generate text');
    }
  } catch (e) {
    // Handle the exception
    return "Error!";
  }
}
