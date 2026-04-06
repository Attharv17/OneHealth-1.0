import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

// Ensure these filenames match exactly with your .dart files
import 'home_tab.dart';
import 'records_tab.dart';
import 'insights_tab.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;

  // REMOVED 'const' from the list and specific tabs to fix your error
  final List<Widget> _screens = [
    const HomeTab(),
    const RecordsTab(),  // Logic inside makes this non-const
    const InsightsTab(), // Logic inside makes this non-const
    const Center(child: Text("Profile Settings", style: TextStyle(fontWeight: FontWeight.bold))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AnimatedSwitcher makes the screen transition smooth when switching tabs
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _navItem(LucideIcons.home, "Home", 0),
                _navItem(LucideIcons.fileText, "Vault", 1),
                _navItem(LucideIcons.sparkles, "AI", 2),
                _navItem(LucideIcons.user, "Profile", 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          // Soft indigo pill background for the active tab
          color: isSelected ? const Color(0xFF6366F1).withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon, 
              color: isSelected ? const Color(0xFF6366F1) : const Color(0xFF94A3B8), 
              size: 22
            ),
            // Only show the label for the selected tab for a "Modern Pill" look
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF6366F1),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}