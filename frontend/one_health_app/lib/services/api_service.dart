import 'package:dio/dio.dart';

class ApiService {
  // Use 10.0.2.2 if testing on Android Emulator, or your local IP for physical devices
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://127.0.0.1:8000'));

  // Test Database Connection
  Future<Map<String, dynamic>> testConnection() async {
    try {
      final response = await _dio.get('/test-db');
      return response.data;
    } catch (e) {
      return {'status': 'error', 'message': e.toString()};
    }
  }

  // Upload a file (Mock OCR)
  Future<Map<String, dynamic>> uploadRecord(String filePath) async {
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(filePath),
      });
      final response = await _dio.post('/records/upload', data: formData);
      return response.data;
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  // Get records for a user
  Future<List<dynamic>> fetchRecords(String userId) async {
    try {
      final response = await _dio.get('/records/record/$userId');
      return response.data['records'];
    } catch (e) {
      return [];
    }
  }
}