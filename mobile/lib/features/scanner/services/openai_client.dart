import 'dart:io';

import 'package:dio/dio.dart';

class OpenAIClient {
  final Dio _dio = Dio();

  /// Uploads [imageFile] to the local proxy and returns a nutrition map.
  /// Expected response: { name, calories, protein, carbs, fat }
  Future<Map<String, dynamic>> scanImage(File imageFile) async {
    final urlCandidates = [
      'http://10.0.2.2:3000/scan', // Android emulator -> host
      'http://localhost:3000/scan',
      'http://127.0.0.1:3000/scan',
    ];

    for (final url in urlCandidates) {
      try {
        // A FormData instance is consumed by Dio after a request. Create a new
        // one for every fallback attempt so the file is uploaded each time.
        final formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split(Platform.pathSeparator).last,
          ),
        });
        final resp = await _dio.post(url, data: formData, options: Options(
          headers: {'Accept': 'application/json'},
          sendTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 30),
        ));

        if (resp.statusCode == 200 && resp.data is Map) {
          return Map<String, dynamic>.from(resp.data as Map);
        }
      } catch (_) {
        // try next
      }
    }

    // fallback: return a generic unknown food
    return {
      'name': 'Unknown food',
      'calories': 0,
      'protein': 0.0,
      'carbs': 0.0,
      'fat': 0.0,
    };
  }
}
