class MedicalRecord {
  final String hospitalName;
  final String date;
  final String category;
  final String summary;
  final List<String> medications;

  MedicalRecord({
    required this.hospitalName, 
    required this.date, 
    required this.category, 
    required this.summary,
    this.medications = const [],
  });
}