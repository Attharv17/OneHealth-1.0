import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class InsightsTab extends StatelessWidget {
  const InsightsTab({super.key});

  static const Color slate800 = Color(0xFF1E293B);
  static const Color indigo600 = Color(0xFF4F46E5);
  static const Color emerald500 = Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("AI Intelligence", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: slate800)),
            const Text("Longitudinal & Predictive Analysis", style: TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 25),
            _buildLongevityScoreCard(),
            const SizedBox(height: 30),
            _buildSectionHeader("Organ System Health", LucideIcons.shieldCheck),
            _buildOrganHealthGrid(),
            const SizedBox(height: 30),
            _buildSectionHeader("Genetic Risk Forecast", LucideIcons.dna),
            _buildGeneticRiskCard(),
            const SizedBox(height: 30),
            _buildSectionHeader("AI Lifestyle Engine", LucideIcons.sparkles),
            _buildLifestyleRecommendations(),
            const SizedBox(height: 30),
            _buildSectionHeader("OneHealth AI Chatbot", LucideIcons.bot),
            _buildAIChatInput(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildLongevityScoreCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(gradient: const LinearGradient(colors: [indigo600, Color(0xFF818CF8)]), borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("AI Predicted Longevity", style: TextStyle(color: Colors.white70, fontSize: 13)),
            Text("82.4 Years", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            Text("+2.1 yrs from last month", style: TextStyle(color: Color(0xFFBBF7D0), fontSize: 11, fontWeight: FontWeight.bold)),
          ]),
          Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle), child: const Icon(LucideIcons.hourglass, color: Colors.white, size: 30)),
        ],
      ),
    );
  }

  Widget _buildOrganHealthGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        _organItem("Heart", "Optimal", Colors.green),
        _organItem("Kidney", "Monitor", Colors.orange),
        _organItem("Liver", "Optimal", Colors.green),
      ],
    );
  }

  Widget _organItem(String n, String s, Color c) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: c.withOpacity(0.05))),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(n, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: slate800)),
        const SizedBox(height: 5),
        Text(s, style: TextStyle(color: c, fontSize: 10, fontWeight: FontWeight.bold)),
      ]),
    );
  }

  Widget _buildGeneticRiskCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: slate800, borderRadius: BorderRadius.circular(24)),
      child: Column(children: [
        _geneticRow("Cardiovascular", "Low Risk", Colors.green),
        const Divider(color: Colors.white10, height: 25),
        _geneticRow("Type-2 Diabetes", "Monitor", Colors.orange),
      ]),
    );
  }

  Widget _geneticRow(String label, String status, Color col) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500)),
      Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: col.withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: Text(status, style: TextStyle(color: col, fontSize: 10, fontWeight: FontWeight.bold))),
    ]);
  }

  Widget _buildLifestyleRecommendations() {
    return Column(children: [
      _recItem("Vascular Training", "Target 145 BPM for 20 mins.", LucideIcons.flame),
      const SizedBox(height: 12),
      _recItem("Omega-3 Increase", "AI identified inflammation markers.", LucideIcons.fish),
    ]);
  }

  Widget _recItem(String t, String d, IconData i) {
    return Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)), child: Row(children: [Icon(i, color: indigo600, size: 24), const SizedBox(width: 15), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(t, style: const TextStyle(fontWeight: FontWeight.bold, color: slate800)), Text(d, style: const TextStyle(color: Colors.grey, fontSize: 11))]))]));
  }

  Widget _buildAIChatInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Ask AI about your reports...",
          prefixIcon: Icon(LucideIcons.messageCircle, color: indigo600, size: 20),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String t, IconData i) {
    return Padding(padding: const EdgeInsets.only(bottom: 15), child: Row(children: [Icon(i, size: 20, color: indigo600), const SizedBox(width: 10), Text(t, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: slate800))]));
  }
}