import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'dart:io';

Future<Response> uploadImage(File imageFile) async {
  var dio = Dio();
  String apiKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiODU0NWFhNjItNjIxYy00NzNhLTkyNzktN2VmOWZhZjI1YjA5IiwidHlwZSI6ImFwaV90b2tlbiJ9.usMATUzTk828oKKulvS3zQHDzWChkZ_lYiA1POHcT_w";
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
