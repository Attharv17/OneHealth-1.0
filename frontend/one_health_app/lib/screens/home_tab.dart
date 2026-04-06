import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  // Global Styles
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate600 = Color(0xFF475569);
  static const Color indigo600 = Color(0xFF4F46E5);
  static const Color emerald500 = Color(0xFF10B981);
  static const Color rose500 = Color(0xFFF43F5E);

  // FEATURE: INTERACTIVE MEDICATION DATA
  List<Map<String, dynamic>> medications = [
    {"name": "Metformin (500mg)", "time": "08:00 AM", "isDone": true},
    {"name": "Vitamin D3", "time": "01:00 PM", "isDone": false},
    {"name": "Aspirin (75mg)", "time": "09:00 PM", "isDone": false},
  ];

  int _waterGlasses = 5;

  // Logic to toggle checkbox
  void _toggleMed(int index) {
    setState(() => medications[index]['isDone'] = !medications[index]['isDone']);
  }

  // Logic to Edit Medication
  void _editMedication(int index) {
    TextEditingController nameController = TextEditingController(text: medications[index]['name']);
    TextEditingController timeController = TextEditingController(text: medications[index]['time']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Update Prescription", style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Medicine Name")),
            TextField(controller: timeController, decoration: const InputDecoration(labelText: "Time (e.g. 10:00 PM)")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              setState(() {
                medications[index]['name'] = nameController.text;
                medications[index]['time'] = timeController.text;
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: indigo600),
            child: const Text("Save Changes", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSOSBanner(),
            _buildHeader(),
            const SizedBox(height: 25),
            _buildDoctorAccessRequest(),
            const SizedBox(height: 20),
            _buildActivityRingCard(),
            const SizedBox(height: 30),
            _buildSectionHeader("Quick Actions", LucideIcons.zap),
            _buildQuickActionsRow(),
            const SizedBox(height: 30),
            _buildSectionHeader("Vitals Hub", LucideIcons.activity),
            _buildVitalsGrid(),
            const SizedBox(height: 30),
            _buildSectionHeader("Medication Schedule", LucideIcons.clock),
            _buildInteractiveTimeline(),
            const SizedBox(height: 30),
            _buildHealthTip(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- HEADER WITH LIVE PULSE ---
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello, Ishan", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: slate800)),
            Text("Your health is 84% optimized.", style: TextStyle(color: slate600, fontSize: 14)),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: rose500.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
          child: const Row(
            children: [
              Icon(LucideIcons.heart, color: rose500, size: 16),
              SizedBox(width: 6),
              Text("72 BPM", style: TextStyle(color: rose500, fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
        )
      ],
    );
  }

  // --- ACTIVITY RINGS (GAMIFICATION) ---
  Widget _buildActivityRingCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [slate800, Color(0xFF334155)]),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Daily Progress", style: TextStyle(color: Colors.white70, fontSize: 13)),
                Text("Keep it up!", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("You've completed 2/3 of your daily goals.", style: TextStyle(color: Colors.white54, fontSize: 11)),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 70, height: 70,
                child: CircularProgressIndicator(value: 0.66, strokeWidth: 8, color: emerald500, backgroundColor: Colors.white10),
              ),
              const Icon(LucideIcons.flame, color: Colors.orange, size: 28),
            ],
          )
        ],
      ),
    );
  }

  // --- INTERACTIVE TIMELINE ---
  Widget _buildInteractiveTimeline() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: List.generate(medications.length, (index) {
          final med = medications[index];
          final bool isLast = index == medications.length - 1;
          return Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _toggleMed(index),
                    child: Icon(
                      med['isDone'] ? LucideIcons.checkCircle2 : LucideIcons.circle,
                      color: med['isDone'] ? emerald500 : Colors.grey.shade300,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(med['name'], 
                          style: TextStyle(
                            fontWeight: FontWeight.bold, 
                            decoration: med['isDone'] ? TextDecoration.lineThrough : null,
                            color: med['isDone'] ? Colors.grey : slate800
                          )
                        ),
                        Text(med['time'], style: const TextStyle(color: Colors.grey, fontSize: 11)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(LucideIcons.edit3, size: 18, color: Colors.grey),
                    onPressed: () => _editMedication(index),
                  )
                ],
              ),
              if (!isLast) const Divider(height: 20, color: Color(0xFFF1F5F9)),
            ],
          );
        }),
      ),
    );
  }

  // --- VITALS GRID ---
  Widget _buildVitalsGrid() {
    return Row(
      children: [
        _vitalCard("SpO2", "98%", "Normal", Colors.blue, LucideIcons.wind),
        const SizedBox(width: 15),
        _vitalCard("Water", "$_waterGlasses/8", "Glasses", Colors.cyan, LucideIcons.droplets, 
          onTap: () => setState(() => _waterGlasses++)),
      ],
    );
  }

  Widget _vitalCard(String l, String v, String s, Color c, IconData i, {VoidCallback? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(i, color: c, size: 20),
              const SizedBox(height: 12),
              Text(v, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(l, style: const TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }

  // --- HEALTH TIP ---
  Widget _buildHealthTip() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: indigo600.withOpacity(0.05), borderRadius: BorderRadius.circular(20)),
      child: const Row(
        children: [
          Icon(LucideIcons.lightbulb, color: indigo600),
          SizedBox(width: 15),
          Expanded(child: Text("AI Tip: Your sleep heart rate was slightly high. Try avoiding caffeine after 6 PM.", 
            style: TextStyle(fontSize: 12, color: slate800, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  // --- REUSED UI HELPERS ---
  Widget _buildSOSBanner() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFFEF2F2), borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xFFFEE2E2))),
      child: const Row(children: [
        Icon(LucideIcons.alertCircle, color: Color(0xFFEF4444), size: 20),
        SizedBox(width: 12),
        Expanded(child: Text("Emergency ID Active", style: TextStyle(color: Color(0xFFB91C1C), fontWeight: FontWeight.bold, fontSize: 13))),
        CircleAvatar(backgroundColor: Color(0xFFEF4444), radius: 15, child: Icon(LucideIcons.phone, color: Colors.white, size: 14)),
      ]),
    );
  }

  Widget _buildDoctorAccessRequest() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFDBEAFE))),
      child: Row(children: [
        const CircleAvatar(backgroundColor: Colors.blue, child: Icon(LucideIcons.userPlus, color: Colors.white, size: 20)),
        const SizedBox(width: 15),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Access Request", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E40AF))),
          Text("Dr. Pravar K. (Cardiology)", style: TextStyle(fontSize: 11, color: Color(0xFF1E40AF))),
        ])),
        ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: const Text("Approve", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
      ]),
    );
  }

  Widget _buildQuickActionsRow() {
    return Row(children: [
      _actionBtn("Consult", LucideIcons.video, Colors.indigo),
      const SizedBox(width: 12),
      _actionBtn("Clinic", LucideIcons.mapPin, Colors.teal),
      const SizedBox(width: 12),
      _actionBtn("Med Wallet", LucideIcons.wallet, Colors.orange),
    ]);
  }

  Widget _actionBtn(String l, IconData i, Color c) {
    return Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: c.withOpacity(0.1))), child: Column(children: [Icon(i, color: c, size: 22), const SizedBox(height: 8), Text(l, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold))])));
  }

  Widget _buildSectionHeader(String t, IconData i) {
    return Padding(padding: const EdgeInsets.only(bottom: 15), child: Row(children: [Icon(i, size: 20, color: indigo600), const SizedBox(width: 10), Text(t, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: slate800))]));
  }
}