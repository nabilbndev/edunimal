import 'dart:convert';

import 'package:dio/dio.dart';

Future<String> generateStory(String text) async {
  final dio = Dio();
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
      'text': "Generate a short and interesting fairytale about $text for kids",
    },
  );

  if (response.statusCode == 200) {
    final responseString = jsonDecode(response.toString());
    return responseString['openai']['generated_text'];
  } else {
    throw Exception('Failed to generate text');
  }
}
