import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'dart:io';
import '../services/api_service.dart';
import '../widgets/record_tile.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ApiService _api = ApiService(); 
  bool _isAnalyzing = false;
  int _waterGlasses = 5;

  // Modern Color Palette (Fixes the Slate/Rose errors)
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate500 = Color(0xFF64748B);
  static const Color rose500 = Color(0xFFF43F5E);
  static const Color indigo600 = Color(0xFF4F46E5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAIChat(),
        backgroundColor: const Color(0xFF6366F1),
        icon: const Icon(LucideIcons.sparkles, color: Colors.white, size: 20),
        label: const Text("Ask OneHealth AI", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                _buildSOSBanner(),
                _buildSecurityBanner(),
                const SizedBox(height: 20),
                _buildHealthScoreCard(),
                const SizedBox(height: 25),
                
                _buildSectionHeader("Live Vitals & Goals", LucideIcons.activity),
                _buildVitalsAndGoalsRow(), // Feature 12 & 13
                
                const SizedBox(height: 25),
                _buildSectionHeader("Quick Actions", LucideIcons.layoutGrid),
                _buildQuickActionsGrid(), // NEW: More useful than symptoms!
                
                const SizedBox(height: 25),
                _buildSectionHeader("Today's Medication Timeline", LucideIcons.clock),
                _buildEnhancedTimeline(), // Better Timeline Layout
                
                const SizedBox(height: 25),
                _buildSectionHeader("AI Lab Trends", LucideIcons.trendingUp),
                _buildLabTrendsCard(), // Feature 14
                
                const SizedBox(height: 25),
                _buildSectionHeader("OCR Report Scanner", LucideIcons.maximize),
                _buildUploadBox(),
                
                const SizedBox(height: 25),
                _buildSectionHeader("Clinical History", LucideIcons.history),
                _buildDoctorAccessCard(),
                RecordTile(title: "SRM Global Hospital", date: "Today", onTap: () {}),
                const SizedBox(height: 100),
              ],
            ),
          ),
          if (_isAnalyzing) _buildLoadingOverlay(),
        ],
      ),
    );
  }

  // --- NEW FEATURE: QUICK ACTIONS GRID ---
  Widget _buildQuickActionsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: [
        _quickActionItem("Tele-Consult", LucideIcons.video, Colors.blue),
        _quickActionItem("Insurance", LucideIcons.award, Colors.orange),
        _quickActionItem("Pharmacies", LucideIcons.mapPin, Colors.teal),
      ],
    );
  }

  Widget _quickActionItem(String label, IconData icon, Color col) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: col.withOpacity(0.1))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: col, size: 24),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // --- FEATURE 13: LIVE VITALS (FIXED COLORS) ---
  Widget _buildVitalsAndGoalsRow() {
    return Row(
      children: [
        Expanded(
          child: _statusCard("Heart Rate", "72 BPM", LucideIcons.heartPulse, rose500, "Synced 2m ago"),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _goalCard("Hydration", "$_waterGlasses / 8", LucideIcons.droplets, Colors.blue, () => setState(() => _waterGlasses++)),
        ),
      ],
    );
  }

  // --- FEATURE: ENHANCED TIMELINE ---
  Widget _buildEnhancedTimeline() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          _timelineItem("Metformin (500mg)", "08:00 AM", true),
          _timelineItem("Vitamin D3", "01:00 PM", false),
          _timelineItem("Aspirin (75mg)", "09:00 PM", false, isLast: true),
        ],
      ),
    );
  }

  Widget _timelineItem(String name, String time, bool isDone, {bool isLast = false}) {
    return Row(
      children: [
        Column(
          children: [
            Icon(isDone ? LucideIcons.checkCircle2 : LucideIcons.circle, color: isDone ? Colors.green : Colors.grey.shade300, size: 20),
            if (!isLast) Container(width: 2, height: 30, color: Colors.grey.shade100),
          ],
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: isDone ? Colors.black87 : Colors.black45)),
                Text(time, style: const TextStyle(fontSize: 12, color: slate500)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- FEATURE: LAB TRENDS ---
  Widget _buildLabTrendsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: slate800, borderRadius: BorderRadius.circular(24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sugar (HbA1c)", style: TextStyle(color: Colors.white70, fontSize: 12)),
              Text("5.7 %", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
            child: const Text("Optimal", style: TextStyle(color: Colors.greenAccent, fontSize: 10, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  // --- STYLE HELPERS ---
  Widget _statusCard(String title, String val, IconData icon, Color col, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: col.withOpacity(0.05), borderRadius: BorderRadius.circular(20), border: Border.all(color: col.withOpacity(0.1))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: col, size: 20),
        const SizedBox(height: 10),
        Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(subtitle, style: const TextStyle(fontSize: 10, color: slate500)),
      ]),
    );
  }

  Widget _goalCard(String title, String val, IconData icon, Color col, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: col, size: 20),
          const SizedBox(height: 10),
          Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Text(title, style: const TextStyle(fontSize: 10, color: slate500)),
        ]),
      ),
    );
  }

  Widget _buildHealthScoreCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [indigo600, Color(0xFF6366F1)]),
        borderRadius: BorderRadius.circular(28),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Health Score", style: TextStyle(color: Colors.white70)),
            Text("84 / 100", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          ]),
          Icon(LucideIcons.heartPulse, color: Colors.white, size: 40),
        ],
      ),
    );
  }

  Widget _buildSOSBanner() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.red.shade200)),
      child: Row(children: [
        const Icon(LucideIcons.alertCircle, color: Colors.red, size: 20),
        const SizedBox(width: 12),
        const Expanded(child: Text("Emergency ID Active", style: TextStyle(color: Color(0xFFB91C1C), fontWeight: FontWeight.bold, fontSize: 13))),
        MaterialButton(color: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), onPressed: () {}, child: const Text("SOS", style: TextStyle(color: Colors.white))),
      ]),
    );
  }

  Widget _buildSecurityBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
      child: const Row(children: [
        Icon(LucideIcons.shieldCheck, color: Colors.green, size: 16),
        SizedBox(width: 8),
        Text("AES-256 Encryption Active", style: TextStyle(color: Color(0xFF15803D), fontSize: 11, fontWeight: FontWeight.w600)),
      ]),
    );
  }

  Widget _buildUploadBox() {
    return GestureDetector(
      onTap: _handleUpload,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.grey.shade200)),
        child: const Column(children: [
          Icon(LucideIcons.filePlus, size: 36, color: Color(0xFF6366F1)),
          SizedBox(height: 10),
          Text("Scan Report", style: TextStyle(fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text("OneHealth", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      actions: [
        const CircleAvatar(radius: 18, backgroundColor: Color(0xFF6366F1), child: Icon(LucideIcons.user, color: Colors.white, size: 18)),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(children: [Icon(icon, size: 18, color: indigo600), const SizedBox(width: 8), Text(title, style: const TextStyle(fontWeight: FontWeight.bold))]),
    );
  }

  Widget _buildDoctorAccessCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(children: [const Icon(LucideIcons.userPlus, color: Colors.blue), const SizedBox(width: 15), const Expanded(child: Text("Access Request")), TextButton(onPressed: () {}, child: const Text("Approve"))]),
    );
  }

  void _showAIChat() {}
  void _handleUpload() {}
  Widget _buildLoadingOverlay() => Container();
}