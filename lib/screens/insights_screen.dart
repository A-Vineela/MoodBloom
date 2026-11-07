import 'package:flutter/material.dart';
import '../models/mood_entry.dart';
import '../widgets/section_title.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key, required this.entries});
  final List<MoodEntry> entries;

  @override
  Widget build(BuildContext context) {
    final counts = {for (final mood in Mood.values) mood: 0};
    for (final entry in entries) {
      counts[entry.mood] = (counts[entry.mood] ?? 0) + 1;
    }
    final total = entries.length;
    final topMood = Mood.values.reduce(
        (a, b) => (counts[a] ?? 0) >= (counts[b] ?? 0) ? a : b);

    return ListView(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 28),
      children: [
        const Text('Your insights',
            style: TextStyle(fontSize: 29, fontWeight: FontWeight.w900)),
        const SizedBox(height: 6),
        const Text('Notice patterns, without judging them.',
            style: TextStyle(color: Colors.black54)),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: const Color(0xFFE8EFE3),
              borderRadius: BorderRadius.circular(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Your mood snapshot',
                  style: TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              Text(total == 0 ? '🌤️' : topMood.emoji,
                  style: const TextStyle(fontSize: 48)),
              Text(total == 0
                  ? 'Your story starts with one check-in.'
                  : 'You logged ${topMood.label.toLowerCase()} most often.',
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
              Text('$total total check-ins',
                  style: const TextStyle(color: Colors.black54)),
            ],
          ),
        ),
        const SizedBox(height: 26),
        const SectionTitle(title: 'Mood distribution'),
        const SizedBox(height: 14),
        ...Mood.values.map((mood) {
          final count = counts[mood] ?? 0;
          final fraction = total == 0 ? 0.0 : count / total;
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('${mood.emoji}  ${mood.label}',
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                    const Spacer(),
                    Text('$count',
                        style: const TextStyle(color: Colors.black54)),
                  ],
                ),
                const SizedBox(height: 7),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: fraction,
                    minHeight: 10,
                    backgroundColor: Colors.white,
                    color: mood.color,
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(18)),
          child: const Text(
            'A gentle reminder: mood tracking is a reflection tool, not a diagnosis. Every feeling deserves space.',
            style: TextStyle(color: Colors.black54, height: 1.4),
          ),
        ),
      ],
    );
  }
}
