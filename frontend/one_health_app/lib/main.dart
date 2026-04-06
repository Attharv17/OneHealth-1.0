import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'api_service.dart';

void main() {
  runApp(const OneHealthApp());
}

class OneHealthApp extends StatelessWidget {
  const OneHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OneHealth',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ApiService _apiService = ApiService();
  List<dynamic> _records = [];
  bool _isLoading = false;
  String _dbStatus = "Checking...";

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  // Check backend connection
  void _checkStatus() async {
    final result = await _apiService.testConnection();
    setState(() {
      _dbStatus = result['status'] ?? "Disconnected";
    });
  }

  // Trigger file picker and upload
  void _pickAndUploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() => _isLoading = true);
      final response = await _apiService.uploadRecord(result.files.single.path!);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Processed: ${response['extracted_text']}")),
      );
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OneHealth Dashboard"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chip(label: Text("DB: $_dbStatus")),
          )
        ],
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: _records.length,
            itemBuilder: (context, index) {
              final record = _records[index];
              return ListTile(
                leading: const Icon(LucideIcons.fileText),
                title: Text(record['title'] ?? "Medical Report"),
                subtitle: Text(record['date'] ?? ""),
              );
            },
          ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _pickAndUploadFile,
        label: const Text("Upload Report"),
        icon: const Icon(LucideIcons.upload),
      ),
    );
  }
}