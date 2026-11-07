
import 'package:flutter/material.dart';

import '../models/mood_entry.dart';
import 'home_screen.dart';
import 'check_in_screen.dart';
import 'insights_screen.dart';
import 'garden_screen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

const Color blush = Color(0xFFFFF4F7);
const Color sidebarPink = Color(0xFFF8E5EC);
const Color deepRose = Color(0xFF925C75);
const Color sage = Color(0xFFE8EFE3);
const Color darkGreen = Color(0xFF344B3B);

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  final List<MoodEntry> _entries = [];
  static const String _entriesStorageKey = 'moodbloom_checkins_v1';

@override
void initState() {
  super.initState();
  _loadEntries();
}

Future<void> _loadEntries() async {
  final prefs = await SharedPreferences.getInstance();
  final saved = prefs.getString(_entriesStorageKey);

  if (saved == null) return;

  try {
    final List<dynamic> data = jsonDecode(saved);

    final restored = data.map((item) {
      final map = item as Map<String, dynamic>;

      return MoodEntry(
        date: DateTime.parse(map['date'] as String),
        mood: Mood.values.firstWhere(
          (mood) => mood.name == map['mood'],
        ),
        note: map['note'] as String? ?? '',
      );
    }).toList();

    if (mounted) {
      setState(() {
        _entries
          ..clear()
          ..addAll(restored);
        _entries.sort((a, b) => b.date.compareTo(a.date));
      });
    }
  } catch (error) {
    debugPrint('Could not restore MoodBloom check-ins: $error');
  }
}

Future<void> _saveEntries() async {
  final prefs = await SharedPreferences.getInstance();

  final data = _entries.map((entry) {
    return {
      'date': entry.date.toIso8601String(),
      'mood': entry.mood.name,
      'note': entry.note,
    };
  }).toList();

  await prefs.setString(_entriesStorageKey, jsonEncode(data));
}

  void _addEntry(MoodEntry entry) {
  setState(() {
    _entries.add(entry);
    _entries.sort((a, b) => b.date.compareTo(a.date));
    _index = 0;
  });

  _saveEntries();
}
  
  void _openCheckIn() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CheckInScreen(
          onSave: _addEntry,
          alreadyCheckedIn: _entries.any((e) =>
              e.date.year == DateTime.now().year &&
              e.date.month == DateTime.now().month &&
              e.date.day == DateTime.now().day),
        ),
      ),
    );
  }

  void _selectPage(int index) {
    setState(() => _index = index);
  }

  List<Widget> get _pages => [
  HomeScreen(entries: _entries, onCheckIn: _openCheckIn),
  InsightsScreen(entries: _entries),
  GardenScreen(entries: _entries),
];

  Widget _sidebar() {
    return Container(
      width: 250,
      color: sidebarPink,
      padding: const EdgeInsets.fromLTRB(18, 30, 18, 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 23,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.spa_rounded, color: deepRose, size: 27),
                ),
                SizedBox(width: 11),
                Expanded(
                  child: Text(
                    'MoodBloom',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      color: deepRose,
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              'YOUR LITTLE SPACE TO GROW',
              style: TextStyle(
                fontSize: 9,
                letterSpacing: 1.3,
                fontWeight: FontWeight.bold,
                color: Color(0xFFAD8296),
              ),
            ),
          ),
          const SizedBox(height: 42),
          const Padding(
            padding: EdgeInsets.only(left: 12, bottom: 12),
            child: Text(
              'MENU',
              style: TextStyle(
                color: Color(0xFFAD8296),
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
          _navItem(
            icon: Icons.grid_view_rounded,
            label: 'Dashboard',
            index: 0,
          ),
          _navItem(
            icon: Icons.favorite_rounded,
            label: 'My Insights',
            index: 1,
          ),
          _navItem(
            icon: Icons.local_florist_rounded,
            label: 'My Garden',
            index: 2,
          ),
          _navItem(
            icon: Icons.edit_note_rounded,
            label: 'Daily Check-in',
            onTap: _openCheckIn,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('🌷', style: TextStyle(fontSize: 27)),
                SizedBox(height: 8),
                Text(
                  'A gentle reminder',
                  style: TextStyle(
                    color: deepRose,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'You are growing at your own pace. Be kind to yourself!',
                  style: TextStyle(
                    color: Color(0xFF8C7180),
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'Made with ♡ for you',
              style: TextStyle(color: Color(0xFFAD8296), fontSize: 11),
            ),
          ),
          ],
        ),
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    int? index,
    VoidCallback? onTap,
  }) {
    final selected = index != null && _index == index;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: selected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap ?? () => _selectPage(index!),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 14,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: selected ? deepRose : const Color(0xFF987B8B),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: selected ? deepRose : const Color(0xFF765D6C),
                      fontWeight:
                          selected ? FontWeight.bold : FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
                if (selected) ...[
                  const SizedBox(width: 6),
                  const Icon(Icons.circle, size: 7, color: deepRose),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 760;

        if (isDesktop) {
          return Scaffold(
            backgroundColor: blush,
            body: Row(
              children: [
                _sidebar(),
                Expanded(
                  child: Container(
                    color: blush,
                    child: SafeArea(
                      child: IndexedStack(
                        index: _index,
                        children: _pages,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          backgroundColor: blush,
          appBar: AppBar(
            backgroundColor: sidebarPink,
            foregroundColor: deepRose,
            elevation: 0,
            title: const Text(
              'MoodBloom 🌷',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          drawer: Drawer(
            backgroundColor: sidebarPink,
            child: SafeArea(child: _sidebar()),
          ),
          body: IndexedStack(
            index: _index,
            children: _pages,
          ),
        );
      },
    );
  }
}
