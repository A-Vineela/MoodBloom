import 'package:flutter/material.dart';
import '../models/mood_entry.dart';
import '../widgets/section_title.dart';
import '../widgets/stat_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.entries,
    required this.onCheckIn,
  });

  final List<MoodEntry> entries;
  final VoidCallback onCheckIn;

  String get _dateLabel {
    final now = DateTime.now();
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[now.month - 1]} ${now.day}';
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    MoodEntry? todayEntry;
    for (final entry in entries) {
      if (entry.date.year == today.year &&
          entry.date.month == today.month &&
          entry.date.day == today.day) {
        todayEntry = entry;
        break;
      }
    }

    final checkedDates = entries
        .map((entry) => DateTime(entry.date.year, entry.date.month, entry.date.day))
        .toSet();
    final todayDate = DateTime(today.year, today.month, today.day);
    final yesterdayDate = todayDate.subtract(const Duration(days: 1));
    var streak = 0;
    var streakDate = checkedDates.contains(todayDate)
        ? todayDate
        : checkedDates.contains(yesterdayDate)
            ? yesterdayDate
            : null;
    while (streakDate != null && checkedDates.contains(streakDate)) {
      streak++;
      streakDate = streakDate.subtract(const Duration(days: 1));
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
      children: [
        const SizedBox(height: 18),
        Text('$_dateLabel  •  Your little daily pause',
            style: const TextStyle(color: Colors.black54, fontSize: 13)),
        const SizedBox(height: 8),
        Text('How are you\nfeeling today?',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 1.12,
                  color: const Color(0xFF263B30),
                )),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFE8EFE3),
            borderRadius: BorderRadius.circular(26),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(todayEntry == null
                        ? 'A small check-in can make a big difference.'
                        : 'You checked in today. Keep nurturing your garden!'),
                    const SizedBox(height: 14),
                    FilledButton.icon(
                      onPressed: onCheckIn,
                      icon: const Icon(Icons.add_rounded),
                      label: Text(todayEntry == null ? 'Check in now' : 'Update mood'),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Text('🌱', style: TextStyle(fontSize: 68)),
            ],
          ),
        ),
        const SizedBox(height: 26),
        const SectionTitle(title: 'Your progress'),
        const SizedBox(height: 12),
        Row(
          children: [
            StatCard(
                icon: Icons.calendar_month_rounded,
                value: '${entries.length}',
                label: 'Check-ins',
                tint: const Color(0xFFFFD166)),
            const SizedBox(width: 10),
            StatCard(
                icon: Icons.local_fire_department_rounded,
                value: '$streak',
                label: 'Day streak',
                tint: const Color(0xFFFFB38A)),
            const SizedBox(width: 10),
            StatCard(
                icon: Icons.eco_rounded,
                value: '${entries.length}',
                label: 'Garden plants',
                tint: const Color(0xFF9BCF9B)),
          ],
        ),
        const SizedBox(height: 26),
        const SectionTitle(title: 'Recent reflections'),
        const SizedBox(height: 12),
        if (entries.isEmpty)
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Text('📔', style: TextStyle(fontSize: 30)),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Your reflections will appear here. Start with one mood check-in!',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ),
          )
        else
          ...entries.take(3).map((entry) => Container(
                margin: const EdgeInsets.only(bottom: 9),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18)),
                child: Row(
                  children: [
                    Text(entry.mood.emoji,
                        style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(entry.mood.label,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text(entry.note.isEmpty ? entry.mood.subtitle : entry.note,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
      ],
    );
  }
}
