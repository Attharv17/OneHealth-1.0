import 'dart:io';

class ApiService {
  // Toggle this to 'true' to show a fake success for the demo if backend fails
  bool useMockData = true;

  Future<Map<String, dynamic>> uploadReport(File file) async {
    // Simulate network delay for the "AI is processing" feel
    await Future.delayed(const Duration(seconds: 3));

    if (useMockData) {
      return {
        "hospital": "SRM Medical Centre",
        "date": "06 April 2026",
        "summary": "Patient shows symptoms of seasonal flu. Prescribed Paracetamol and rest.",
        "status": "success"
      };
    }
    
    // TODO: Connect to teammate's FastAPI here later
    throw UnimplementedError("Connect to FastAPI URL");
  }
}